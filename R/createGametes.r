#' create gametes array
#' 
#' create gametes based on the frequency of genotypes in the population and the recombination rate.
#' This is refactored from code in runModel()
#' 
#' @param f array with frequencies of genotypes in the popn.
#' @param recomb_rate recombination rate 
#' 
#' @examples 
#' #createGametes() 
#' @return array
#' @export



createGametes <- function( f, recomb_rate)
{


  #!r can probably refactor further later, keep it close to original to start
  G <- createArray2( sex=c('m','f'), locus1 = c('S1','R1'), locus2 = c('S2','R2') )
    
    
  #!r initially assume same for m & f (i think it is same in Beths code)
  #we can make different later for sex linkage if needs be
  
  for(sex in c('m','f'))
  {
    #i think don't need to set gametes to 0 because they are initialised at 0
    
    
# #no recombination
# G.f.R1.R2 <- G.f.R1.R2 + f.f.RS1RS2_cis * 0.5 * ( 1-recomb_rate ) 
# G.f.S1.S2 <- G.f.S1.S2 + f.f.RS1RS2_cis * 0.5 * ( 1-recomb_rate )
# # recombination takes place
# G.f.S1.R2 <- G.f.S1.R2 + f.f.RS1RS2_cis * 0.5 * recomb_rate			
# G.f.R1.S2 <- G.f.R1.S2 + f.f.RS1RS2_cis * 0.5 * recomb_rate
 
#todo : reduce code repetition in following, maybe by creating a function    
       
    # f.*.RS1RS2_cis
    # no recombination
    G[sex,'R1','R2'] <- G[sex,'R1','R2'] + f[sex,'RS1RS2_cis'] * 0.5 * ( 1-recomb_rate )
    G[sex,'S1','S2'] <- G[sex,'S1','S2'] + f[sex,'RS1RS2_cis'] * 0.5 * ( 1-recomb_rate )
    # recombination takes place
    G[sex,'S1','R2'] <- G[sex,'S1','R2'] + f[sex,'RS1RS2_cis'] * 0.5 * recomb_rate			
    G[sex,'R1','S2'] <- G[sex,'R1','S2'] + f[sex,'RS1RS2_cis'] * 0.5 * recomb_rate
    
    
# # no recombination
# G.f.R1.S2 <- G.f.R1.S2 + f.f.RS1RS2_trans * 0.5 * ( 1-recomb_rate )		
# G.f.S1.R2 <- G.f.S1.R2 + f.f.RS1RS2_trans * 0.5 * ( 1-recomb_rate )
# # recombination takes place
# G.f.R1.R2 <- G.f.R1.R2 + f.f.RS1RS2_trans * 0.5 * recomb_rate
# G.f.S1.S2 <- G.f.S1.S2 + f.f.RS1RS2_trans * 0.5 * recomb_rate
    
    # f.*.RS1RS2_trans
    # no recombination
    G[sex,'R1','S2'] <- G[sex,'R1','S2'] + f[sex,'RS1RS2_trans'] * 0.5 * ( 1-recomb_rate )		
    G[sex,'S1','R2'] <- G[sex,'S1','R2'] + f[sex,'RS1RS2_trans'] * 0.5 * ( 1-recomb_rate )
    # recombination takes place
    G[sex,'R1','R2'] <- G[sex,'R1','R2'] + f[sex,'RS1RS2_trans'] * 0.5 * recomb_rate
    G[sex,'S1','S2'] <- G[sex,'S1','S2'] + f[sex,'RS1RS2_trans'] * 0.5 * recomb_rate
    

# G.f.S1.S2 <- G.f.S1.S2 + (f.f.SS1SS2 * 1.0 +
#                           f.f.SS1RS2 * 0.5 +
#                           f.f.RS1SS2 * 0.5 )     
    #SS Gametes
    G[sex,'S1','S2'] <- G[sex,'S1','S2'] + (f[sex,'SS1SS2'] * 1 +
                                              f[sex,'SS1RS2'] * 0.5 +
                                              f[sex,'RS1SS2'] * 0.5 )
# G.f.R1.S2 <- G.f.R1.S2 + (f.f.RS1SS2 * 0.5 +
#                           f.f.RR1SS2 * 1.0 +
#                           f.f.RR1RS2 * 0.5)    
    #RS Gametes
    G[sex,'R1','S2'] <- G[sex,'R1','S2'] + (f[sex,'RS1SS2'] * 0.5 +
                                              f[sex,'RR1SS2'] * 1 +
                                              f[sex,'RR1RS2'] * 0.5 )
# G.f.S1.R2 <- G.f.S1.R2 + (f.f.SS1RS2 * 0.5 +
#                           f.f.SS1RR2 * 1.0 +
#                           f.f.RS1RR2 * 0.5 )
    #SR Gametes
    G[sex,'S1','R2'] <- G[sex,'S1','R2'] + (f[sex,'SS1RS2'] * 0.5 +
                                              f[sex,'SS1RR2'] * 1 +
                                              f[sex,'RS1RR2'] * 0.5 )
#     G.f.R1.R2 <- G.f.R1.R2 + (f.f.RS1RR2 * 0.5 +
#                               f.f.RR1RS2 * 0.5 +
#                               f.f.RR1RR2 * 1.0 )
    #RR Gametes
    G[sex,'R1','R2'] <- G[sex,'R1','R2'] + (f[sex,'RR1RR2'] * 1 +
                                              f[sex,'RR1RS2'] * 0.5 +
                                              f[sex,'RS1RR2'] * 0.5 )
  }
  
  #return gametes array
  invisible(G)
  
}