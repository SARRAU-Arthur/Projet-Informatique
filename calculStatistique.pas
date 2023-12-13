program CalculatriceStatistique;

uses unitstats;
var
  TabI: subtab;
  tab_med: tableau1D;
  n: integer;

begin
SaisirTableau(TabI,n);
creationtableau(tab_med,TabI);
CalculerMediane(tab_med);
CalculerMoyenne(tab_med);
CalculerVariance(tab_med);
CalculerEcartType(CalculerVariance(tab_med));
end.
