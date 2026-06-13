// ================================================================
// trophy_advisor.ash — Kingdom of Loathing Trophy Advisor
// Compatible with older KoL Mafia builds (no have_trophy needed)
//
// USAGE:
//   ash trophy_advisor.ash
//   ash trophy_advisor.ash verbose   — also list owned trophies
//   ash trophy_advisor.ash run       — add ascension planning hints
//   ash trophy_advisor.ash all       — everything
// ================================================================

boolean G_VERBOSE  = false;
int G_HAVE=0; int G_READY=0; int G_EASY=0;
int G_MOD=0;  int G_HARD=0;  int G_SKIP=0;

// ---- Trophy detection via trophies.php ----
// Maps trophy number to the image filename string shown on the page.
// We fetch the page once and search for each filename.
string _trophy_cache = "";

string [int] TF;  // trophy filename map

void init_trophy_map() {
    TF[1]  = "gonna need a smaller boat";
    TF[2]  = "party on the big boat";
    TF[3]  = "get oot eh";
    TF[4]  = "heavy lourde";
    TF[5]  = "crushed under pets";
    TF[6]  = "awwwwww";
    TF[7]  = "yeti pants now";
    TF[8]  = "a dog a plan";
    TF[9]  = "big head todd";
    TF[10] = "the nastiest cocktail";
    TF[11] = "ghuolishly good";
    TF[12] = "you done took my toast";
    TF[14] = "van went";
    TF[15] = "dirt and dirty";
    TF[16] = "angst with extra cheese";
    TF[17] = "he aint heavy hes my familiar";
    TF[18] = "shakin the bush here boss";
    TF[19] = "nice trophy pablo honey";
    TF[20] = "in a little toy shop";
    TF[21] = "go go gadget trophy";
    TF[22] = "dancing in the dark";
    TF[23] = "master of nuns";
    TF[24] = "gored to the core";
    TF[25] = "you damned dirty human";
    TF[26] = "look what i can do";
    TF[27] = "not worth the wait";
    TF[28] = "no less than three";
    TF[29] = "thats too friendly pippin";
    TF[30] = "run over by grandma";
    TF[31] = "the dude abides";
    TF[32] = "not wearing any pants";
    TF[33] = "with friends like these";
    TF[34] = "ladies and gentlemen";
    TF[35] = "hood ornament";
    TF[36] = "better than bad its good";
    TF[37] = "no well ten beers";
    TF[38] = "you shot the invisible swordsman";
    TF[39] = "in deep end ents";
    TF[40] = "also ate zarathustra";
    TF[41] = "undercover clubber";
    TF[42] = "tortoise reform";
    TF[43] = "stop noodling around";
    TF[44] = "lost in the sauce once again";
    TF[45] = "saturday night inferno";
    TF[46] = "dance round the room to accordion keys";
    TF[47] = "your mom knows the butler";
    TF[48] = "whoops whoops whoops";
    TF[49] = "eliza knew best";
    TF[50] = "and a filthy job it is";
    TF[51] = "gonna go fondle my sweaters";
    TF[52] = "like a cucumber on pluto";
    TF[53] = "horror has a new name";
    TF[54] = "melodious and mellifluous";
    TF[55] = "this parrot is nude";
    TF[56] = "my shrimps was dead and gone";
    TF[57] = "jeremiah was a bullfrog";
    TF[58] = "jeff was right";
    TF[59] = "howd you do that man thats creepy";
    TF[60] = "but it doesnt love me back";
    TF[61] = "dont worry your pretty little head";
    TF[62] = "just like tara reid";
    TF[63] = "you were devoutly aligned";
    TF[64] = "kick em when theyre up";
    TF[65] = "this boat sucks";
    TF[66] = "now ive seen it all";
    TF[67] = "in soviet russia minstrels eat you";
    TF[68] = "what the hell are colitas anyway";
    TF[69] = "just like grandmas dentures";
    TF[70] = "who runs bartertown";
    TF[71] = "and thats all";
    TF[72] = "i hardly know her";
    TF[73] = "what do you want on your tombstone";
    TF[74] = "ill make a note of it";
    TF[75] = "hippy hippy shake";
    TF[76] = "on channel z";
    TF[77] = "tong tong tong tong ta tong tong";
    TF[78] = "now all you need is a sickle";
    TF[79] = "two tickets to anville";
    TF[80] = "hey vern its jewels";
    TF[81] = "visitors stink earlier";
    TF[82] = "garble varble zous";
    TF[83] = "dodecahardon";
    TF[84] = "im a little bit country";
    TF[85] = "oh i get by";
    TF[86] = "every which way but footloose";
    TF[87] = "especially those face scars";
    TF[88] = "screw you atkins";
    TF[89] = "please dont taste the rainbow";
    TF[90] = "steal this music";
    TF[91] = "raggedy annie leibovitz";
    TF[92] = "thats numberwang";
    TF[93] = "aeris kills dumbledore";
    TF[94] = "ocd genocide";
    TF[95] = "giant blue pool cue";
    TF[96] = "in a fruit fight";
    TF[97] = "ocd i choose you";
    TF[98] = "ow my everything";
    TF[99] = "spay or neuter your pets";
    TF[100] = "sweat grope punch repeat";
    TF[101] = "tatsumaki senpuu kyaku";
    TF[102] = "fisting for dollars";
    TF[103] = "wal mart is stationary";
    TF[104] = "gonna need a bigger plaque";
    TF[105] = "look out death adder";
    TF[106] = "never sicker";
    TF[107] = "papier i hardly know her";
    TF[108] = "for your weiner am i right ha ha ha";
    TF[109] = "haggis is as haggis does";
    TF[110] = "i can taste the cosmos";
    TF[111] = "natures harmonic";
    TF[112] = "time to get a dog i guess";
    TF[113] = "little asian different";
    TF[114] = "fruity egocentric magician";
    TF[115] = "more or less right time";
    TF[116] = "taste the pain";
    TF[117] = "ermagerd berks";
    TF[118] = "clear eyes dumb shirt";
    TF[119] = "warranty sold separately";
    TF[120] = "bastard son thereof";
    TF[121] = "dont bleed it all in one place";
    TF[122] = "this is getting ridiculous";
    TF[123] = "could you describe the ruckus";
    TF[124] = "who here knows quark express";
    TF[125] = "take a chanceacus";
    TF[126] = "put gilded lilies in it";
    TF[127] = "wheel of space";
    TF[128] = "pez porridge hot";
    TF[129] = "oh no not again";
    TF[130] = "hero dreams of gyros";
    TF[131] = "d c cab squared";
    TF[132] = "the choice of an old generation";
    TF[133] = "barfily ever after";
    TF[134] = "criminal conspiracy";
    TF[135] = "you ruin everything";
    TF[136] = "the harder side of sears";
    TF[137] = "cool gold jeff game cool";
    TF[138] = "shirto redbetter";
    TF[139] = "may the force boldy go a wizard";
    TF[140] = "she told me to pick up olives";
    TF[141] = "baloneysaurux text";
    TF[142] = "bananarama crux";
    TF[143] = "badonkadonkus_flex";
    TF[144] = "banangrama xer";
    TF[146] = "college kids and divorced men";
    TF[147] = "anger management about schmidt";
    TF[148] = "this town needs an enema";
    TF[149] = "this this lemonade";
    TF[150] = "ilovewesley";
    TF[151] = "oh the horror";
    TF[152] = "all you need is it";
    TF[153] = "i had to drink from the liquid cup";
    TF[154] = "in space noone can hear you laugh";
    TF[155] = "eleven inch flautist";
    TF[156] = "cross about naught";
    TF[157] = "working class republican";
    TF[158] = "yule be happy";
    TF[159] = "we found a dead mouse";
    TF[160] = "twenty two eyes";
    TF[161] = "cuppa cuppa burning goo";
    TF[162] = "every christmas is like sunday";
    TF[163] = "no religion too";
    TF[164] = "skysubmarine";
    TF[165] = "godricks got nothing on you";
    TF[166] = "the third time is the chapeau";
}

boolean has_trophy(int num) {
    if (!(TF contains num)) return false;
    if (_trophy_cache == "") {
        _trophy_cache = visit_url("trophies.php");
    }
    string fname = TF[num].replace_string(" ", "_");
    return contains_text(_trophy_cache, fname);
}

// ---- Display helpers ----
void hr() {
    print_html("<font color='#404040'>──────────────────────────────────────</font>");
}
void section(string t, string c) {
    print_html("");
    print_html("<font color='" + c + "' size='+1'><b>" + t + "</b></font>");
    hr();
}
void tip(int num, string name, string tag, string advice) {
    string col;
    if      (tag == "READY")    { col = "#ccaa00"; G_READY++; }
    else if (tag == "EASY")     { col = "#9944cc"; G_EASY++;  }
    else if (tag == "MODERATE") { col = "#4477cc"; G_MOD++;   }
    else if (tag == "GRIND")    { col = "#339966"; G_HARD++;  }
    else if (tag == "SEASONAL") { col = "#777799"; G_MOD++;   }
    else                        { col = "#555566"; G_SKIP++;  }
    print_html("<font color='" + col + "'><b>[" + tag + "]</b></font> <b>#" + num + " - " + name + "</b>");
    if (advice != "") print_html("&nbsp;&nbsp;&nbsp;<font color='#bbbbbb'>-> " + advice + "</font>");
}
void owned(int num, string name) {
    G_HAVE++;
    if (G_VERBOSE) print_html("<font color='#336633'>HAVE #" + num + " " + name + "</font>");
}
// Check trophy and call owned() or return false for further processing
boolean chk(int num, string name) {
    if (has_trophy(num)) { owned(num, name); return true; }
    return false;
}

// ---- Item/effect helpers using runtime lookup (avoids parse-time errors) ----
boolean have_item_rt(string iname) {
    return item_amount(to_item(iname)) > 0;
}
boolean closet_has_rt(string iname, int qty) {
    return closet_amount(to_item(iname)) >= qty;
}
boolean have_effect_rt(string ename) {
    effect e = to_effect(ename);
    if (e == $effect[none]) return false;
    return have_effect(e) > 0;
}
boolean equipped_rt(slot s, string iname) {
    item i = to_item(iname);
    if (i == $item[none]) return false;
    return equipped_item(s) == i;
}
boolean have_skill_rt(string sname) {
    skill sk = to_skill(sname);
    if (sk == $skill[none]) return false;
    return have_skill(sk);
}

// ================================================================
// MAIN
// ================================================================
void main(string args) {
    init_trophy_map();

    string la = to_lower_case(args);
    G_VERBOSE  = contains_text(la,"verbose") || contains_text(la,"-v") || contains_text(la,"all");

    // Determine if in a run (avoid in_ronin() which may not exist)
    boolean in_hc   = in_hardcore();
    boolean in_ron  = get_property("roninLeft").to_int() > 0;
    boolean in_run  = in_hc || in_ron;

    print_html("<font color='#ccaa00'><b>KoL Trophy Advisor</b></font>");
    print_html("Player: <b>" + my_name() + "</b>  Class: <b>" + my_class() + "</b>  Level: <b>" + my_level() + "</b>");
    print_html("Fetching trophy cabinet...");
    // Warm the cache now so progress is visible
    _trophy_cache = visit_url("trophies.php");
    if (in_run) print_html("<font color='#ffaa44'>Currently in " + (in_hc ? "Hardcore" : "Ronin") + ".</font>");

    // ============================================================
    // SECTION 1 — READY TO BUY
    // ============================================================
    section("READY TO BUY NOW - Visit the Trophy Hut!", "#ccaa00");
    boolean any_ready = false;

    // #36 — Your Log Saw Something That Night
    if (!chk(36,"Your Log Saw Something That Night")) {
        if (contains_text(get_property("notes"),"Laura Palmer")) {
            tip(36,"Your Log Saw Something That Night","READY","'Laura Palmer' is in your Quest Log notes. Go buy it!"); any_ready=true;
        }
    }

    // #49 — Moderation In All Things
    if (!chk(49,"Moderation In All Things")) {
        if (my_fullness()==11 && my_inebriety()==11 && my_spleen_use()==11) {
            tip(49,"Moderation In All Things","READY","F=11 D=11 S=11. Buy BEFORE rollover or consuming anything!"); any_ready=true;
        }
    }

    // #37 — Little Chickadee
    if (!chk(37,"Little Chickadee")) {
        if (my_inebriety() >= 1000) {
            tip(37,"Little Chickadee","READY",my_inebriety()+" drunk! Buy BEFORE midnight rollover - resets to 0!"); any_ready=true;
        }
    }

    // #20 — 99 Red Balloons
    if (!chk(20,"99 Red Balloons")) {
        if (item_amount($item[red balloon]) >= 99) {
            tip(20,"99 Red Balloons","READY",item_amount($item[red balloon])+" red balloons. Multi-use exactly 99 from inventory, then buy."); any_ready=true;
        }
    }

    // #107 — Papier Than Thou
    if (!chk(107,"Papier Than Thou")) {
        item pinata = to_item("papier-mache trophy pinata");
        if (pinata != $item[none] && item_amount(pinata) > 0) {
            tip(107,"Papier Than Thou","READY","Pinata in inventory! Use it then visit Trophy Hut."); any_ready=true;
        }
    }

    // #100 — Mixed Martial Arts
    if (!chk(100,"Mixed Martial Arts")) {
        if (have_skill_rt("Kung Fu Hustler") && have_skill_rt("Master of the Surprising Fist")) {
            tip(100,"Mixed Martial Arts","READY","Both skills permed. Visit Trophy Hut!"); any_ready=true;
        }
    }

    // #138 — Option Paralysis
    if (!chk(138,"Option Paralysis")) {
        if (equipped_rt($slot[shirt],"red shirt") && have_effect_rt("Red-Shirted Escort")) {
            tip(138,"Option Paralysis","READY","Red shirt + Red-Shirted Escort active. Buy now!"); any_ready=true;
        }
    }

    // #64 — Dirty Laundry
    if (!chk(64,"Dirty Laundry")) {
        if (closet_has_rt("spooky pirate skeleton", 13)) {
            tip(64,"Dirty Laundry","READY","13+ spooky pirate skeletons in closet. Buy!"); any_ready=true;
        }
    }

    // Elemental form trophies
    if (!chk(51,"Hothouse Hero")) {
        if (have_effect_rt("Hotform")) { tip(51,"Hothouse Hero","READY","Hotform active! Stack 100+ Hot damage gear then buy."); any_ready=true; }
    }
    if (!chk(52,"Cool Customer")) {
        if (have_effect_rt("Coldform")) { tip(52,"Cool Customer","READY","Coldform active! Stack 100+ Cold damage then buy."); any_ready=true; }
    }
    if (!chk(53,"Dreadful, Just Dreadful")) {
        if (have_effect_rt("Spookyform")) { tip(53,"Dreadful, Just Dreadful","READY","Spookyform active! Stack 100+ Spooky damage then buy."); any_ready=true; }
    }
    if (!chk(54,"Malodorous")) {
        if (have_effect_rt("Stenchform")) { tip(54,"Malodorous","READY","Stenchform active! Stack 100+ Stench damage then buy."); any_ready=true; }
    }
    if (!chk(55,"Wink Wink, Nudge Nudge")) {
        if (have_effect_rt("Sleazeform")) { tip(55,"Wink Wink, Nudge Nudge","READY","Sleazeform active! Stack 100+ Sleaze damage then buy."); any_ready=true; }
    }

    // #87 — Every Part of the Seal (check hat slot as proxy)
    if (!chk(87,"Every Part of the Seal")) {
        if (equipped_rt($slot[hat],"seal-hide hat") && equipped_rt($slot[pants],"seal-hide pants")) {
            tip(87,"Every Part of the Seal","READY","Seal-hide outfit equipped! Buy the trophy."); any_ready=true;
        }
    }

    if (!any_ready) print_html("<font color='#555555'><i>Nothing purchasable right now. Work on sections below.</i></font>");

    // ============================================================
    // SECTION 2 — EASY
    // ============================================================
    section("EASY - Quick Wins", "#9944cc");

    if (!has_trophy(36) && !contains_text(get_property("notes"),"Laura Palmer"))
        tip(36,"Your Log Saw Something That Night","EASY","Quest Log > Notes tab > type 'Laura Palmer' > save. Under 1 minute!");

    if (!has_trophy(138) && !(equipped_rt($slot[shirt],"red shirt") && have_effect_rt("Red-Shirted Escort")))
        tip(138,"Option Paralysis","EASY","Equip red shirt + get Red-Shirted Escort effect, then buy. Red shirt from Daily Dungeon or mall.");

    if (!chk(10,"Disgusting Cocktail"))
        tip(10,"Disgusting Cocktail","EASY","Drink 5 tomato daiquiris total (tomato + bottle of rum, basic cocktailcrafting).");

    if (!chk(9,"Platinum Skull"))
        tip(9,"Platinum Skull","EASY","Eat 5 bowls of spaghetti with Skullheads total. Craft or buy from mall.");

    if (!chk(11,"The Ghuol Cup"))
        tip(11,"The Ghuol Cup","EASY","Eat 11 pans of ghuol guolash total. Craft: ghuol egg + hot buttered roll.");

    if (!chk(140,"11 Martini Breakfast"))
        tip(140,"11 Martini Breakfast","EASY","Drink 11 mini-martinis total (olive + bottle of gin). Very accessible!");

    if (!chk(28,"Three-Tiered Trophy"))
        tip(28,"Three-Tiered Trophy","EASY","Eat a three-tiered wedding cake. Craft or buy from mall (~1k meat).");

    if (!chk(152,"LOVE, LOVE, LOVE"))
        tip(152,"LOVE, LOVE, LOVE","EASY","Solve the L.O.V. Exit puzzle in The Neverending Party.");

    if (!chk(129,"Very Like a Whale"))
        tip(129,"Very Like a Whale","EASY","Make a bowl of petunias: porcelain bowl + deep-sea petunias (both from The Sea).");

    if (!chk(133,"Thar She Blows!"))
        tip(133,"Thar She Blows!","EASY","The Prince's Ball: let Cinderella drink enough to throw up on the Prince's shoes.");

    if (!chk(134,"Partners in Crime"))
        tip(134,"Partners in Crime","EASY","The Prince's Ball: choose options to conspire to frame Cinderella.");

    if (!chk(135,"Party Killer"))
        tip(135,"Party Killer","EASY","The Prince's Ball: knock Cinderella out with 2 laudanum-laced Cannoli.");

    if (!chk(136,"Master Craftsman"))
        tip(136,"Master Craftsman","EASY","Master glass, filling, and parchment in Rumpelstiltskin's Workshop.");

    if (!chk(162,"Dreaming of a Bland Crimbo"))
        tip(162,"Dreaming of a Bland Crimbo","EASY","Eat bread man + eggwater + flour cookie + plain candy cane (bland Crimbo/mall).");

    if (!chk(122,"Eleven Down, None to Go"))
        tip(122,"Eleven Down, None to Go","EASY","Defeat a 1-fingered Shop Teacher (Crimbo Town craftworks).");

    if (!chk(132,"Always Cloaca Cola"))
        tip(132,"Always Cloaca Cola","EASY","Use 11 bottles of Cloaca Cola Polar total.");

    if (!chk(149,"A Gallon of Milk Keeps the Doctor Away"))
        tip(149,"A Gallon of Milk Keeps the Doctor Away","EASY","Eat 7 gallons of milk total.");

    if (!has_trophy(107)) {
        item pinata = to_item("papier-mache trophy pinata");
        if (pinata == $item[none] || item_amount(pinata) == 0)
            tip(107,"Papier Than Thou","EASY","Use a papier-mache trophy pinata. Check the mall.");
    }

    if (!chk(155,"Ultimate Cosmic Power"))
        tip(155,"Ultimate Cosmic Power","EASY","Complete the Genie bottle puzzle fully (all wish types including the ultimate wish).");

    if (!chk(156,"Commemorative Replica Blob"))
        tip(156,"Commemorative Replica Blob","EASY","Defeat a giant amorphous blob (accessible aftercore).");

    if (!chk(157,"You Do It To Yourself"))
        tip(157,"You Do It To Yourself","EASY","Vote for negative local initiatives 11 times at the Daily Loathing Ballot.");

    if (!chk(12,"Der Toastdieb"))
        tip(12,"Der Toastdieb","EASY","Win toast from another player in PvP. One fight is all it takes.");

    // ============================================================
    // SECTION 3 — MODERATE
    // ============================================================
    section("MODERATE - Some Planning Required", "#4477cc");

    if (!has_trophy(49) && !(my_fullness()==11 && my_inebriety()==11 && my_spleen_use()==11))
        tip(49,"Moderation In All Things","MODERATE",
            "Need F=11 D=11 S=11 simultaneously. Currently F="+my_fullness()+" D="+my_inebriety()+" S="+my_spleen_use()+". Plan a day to hit all three at once.");

    if (!chk(3,"I Heart Canadia"))
        tip(3,"I Heart Canadia","MODERATE","Drink 30 white Canadians total (cocktail onion + vodka, advanced cocktailcrafting).");

    if (!chk(34,"Gender Bender"))
        tip(34,"Gender Bender","MODERATE","30 sex changes in The Sleazy Back Alley total (~500 meat each, easy aftercore session).");

    if (!has_trophy(51) && !have_effect_rt("Hotform"))
        tip(51,"Hothouse Hero","MODERATE","Need Hotform + 100 bonus Hot damage. Hotform from Melvign at Gnomad Camp.");
    if (!has_trophy(52) && !have_effect_rt("Coldform"))
        tip(52,"Cool Customer","MODERATE","Need Coldform + 100 bonus Cold damage. Coldform from Melvign at Gnomad Camp.");
    if (!has_trophy(53) && !have_effect_rt("Spookyform"))
        tip(53,"Dreadful, Just Dreadful","MODERATE","Need Spookyform + 100 bonus Spooky damage. Spookyform from Melvign.");
    if (!has_trophy(54) && !have_effect_rt("Stenchform"))
        tip(54,"Malodorous","MODERATE","Need Stenchform + 100 bonus Stench damage. Stenchform from Melvign.");
    if (!has_trophy(55) && !have_effect_rt("Sleazeform"))
        tip(55,"Wink Wink, Nudge Nudge","MODERATE","Need Sleazeform + 100 bonus Sleaze damage. Sleazeform from Melvign.");

    if (!has_trophy(64)) {
        int sk = closet_amount(to_item("spooky pirate skeleton"));
        if (sk < 13)
            tip(64,"Dirty Laundry","MODERATE","Need 13 spooky pirate skeletons in closet. Have "+sk+"/13. Farm Haunted Ship (Pirates Cove).");
    }

    if (!has_trophy(87))
        tip(87,"Every Part of the Seal","MODERATE","Equip full seal-hide outfit: hat + buckler + belt + pants + tooth (Seal Clubber, craft at Icy Peak). Then buy trophy.");

    if (!has_trophy(116))
        tip(116,"Dreadful Rainbow","MODERATE","Get all 5 Dreadsylvania elemental non-combat buffs active simultaneously, then buy.");

    if (!has_trophy(20) && item_amount($item[red balloon]) < 99)
        tip(20,"99 Red Balloons","MODERATE","Need 99 red balloons. Have "+item_amount($item[red balloon])+"/99. Farm Haunted Conservatory or buy mall.");

    if (!chk(82,"Losing Your Marbles"))
        tip(82,"Losing Your Marbles","MODERATE","Complete full marble set, use big bumboozer marble, choose to sell to The Collector.");

    if (!chk(89,"Color Wheel of Yuck"))
        tip(89,"Color Wheel of Yuck","MODERATE","Discover all Slime Potion recipes by mixing slime tube drops.");

    if (!chk(112,"Great Responsibility"))
        tip(112,"Great Responsibility","MODERATE","Keep a ChibiBuddy alive 11 real-world days. Feed it daily. Buy from Mr. Store or mall.");

    if (!chk(126,"Bronzed Tin Can"))
        tip(126,"Bronzed Tin Can","MODERATE","Drink all A Beer Garden beers in one day (Haunted Billiards Room). State-based - buy immediately after last beer.");

    if (!chk(141,"Golden Pickaxe"))
        tip(141,"Golden Pickaxe","MODERATE","Complete Tales of Spelunking 9 times total.");

    if (!chk(142,"Golden Idol"))
        tip(142,"Golden Idol","MODERATE","Beat LOLmec in Tales of Spelunking.");

    if (!chk(143,"Golden Moustache"))
        tip(143,"Golden Moustache","MODERATE","Beat Yomama in Tales of Spelunking.");

    if (!chk(144,"Golden Burglar"))
        tip(144,"Golden Burglar","MODERATE","Beat 10 shopkeepers total in Tales of Spelunking.");

    if (!chk(146,"Some Assembly Required"))
        tip(146,"Some Assembly Required","MODERATE","Assemble 6 different VYKEA furniture types.");

    if (!chk(147,"Bucket List"))
        tip(147,"Bucket List","MODERATE","Complete 10 bucket quests for Walford (Haunted Sorority House).");

    if (!chk(148,"Gotpork Connoisseur"))
        tip(148,"Gotpork Connoisseur","MODERATE","Consume one of each 9 Gotpork villain drops (Bat City/Gotpork aftercore).");

    if (!chk(150,"Prime Directive Director"))
        tip(150,"Prime Directive Director","MODERATE","Solve all 5 Far Future scenarios without bloodshed (spaceship aftercore).");

    if (!chk(124,"Ansel Adams Jr."))
        tip(124,"Ansel Adams Jr.","MODERATE","Fully upgrade Yearbook Club Camera (repeated yearbook club visits over multiple runs).");

    if (!chk(125,"No Particular Reason"))
        tip(125,"No Particular Reason","MODERATE","Defeat 1000 monsters wearing a bone abacus. Passive - keep it equipped while farming.");

    if (!chk(128,"EEZY PEEZY"))
        tip(128,"EEZY PEEZY","MODERATE","Collect all 37 PEEZ dispensers.");

    if (!chk(131,"Alia Iacta Est"))
        tip(131,"Alia Iacta Est","MODERATE","Get full Tiny Die-Cast series 1 set in your Display Case.");

    if (!chk(154,"Salads of Many Worlds"))
        tip(154,"Salads of Many Worlds","MODERATE","Eat 11 primitive alien salads (Spacegate/Far Future content).");

    if (!chk(160,"Talking Heads"))
        tip(160,"Talking Heads","MODERATE","Have all 11 Beach Head buffs active simultaneously (The Sea beachcombing). State-based.");

    if (!chk(59,"Eerily Skilled"))
        tip(59,"Eerily Skilled","MODERATE","Obtain all 6 Spookyraven skills (from Haunted Library/Gallery/Bedroom).");

    if (!chk(104,"Grand Slammer"))
        tip(104,"Grand Slammer","MODERATE","Get all 11 unique pogs on the field simultaneously (Pog game content).");

    if (!chk(23,"Jack of Several Trades")) {
        int gs=0;
        if(have_skill_rt("Torso Awaregness"))         gs++;
        if(have_skill_rt("Gnefarious Pickpocketing")) gs++;
        if(have_skill_rt("Powers of Observatiogn"))   gs++;
        if(have_skill_rt("Cosmic Ugnderstanding"))    gs++;
        if(have_skill_rt("Gnomish Hardigness"))       gs++;
        tip(23,"Jack of Several Trades","MODERATE","Perm all 5 Fragnk gnome skills. Have "+gs+"/5: Torso Awaregness, Gnefarious Pickpocketing, Powers of Observatiogn, Cosmic Ugnderstanding, Gnomish Hardigness.");
    }

    if (!chk(26,"Trivially Skilled")) {
        int cs=0;
        if(have_skill_rt("Seal Clubbing Frenzy")) cs++;
        if(have_skill_rt("Headbutt"))             cs++;
        if(have_skill_rt("Spaghetti Spear"))      cs++;
        if(have_skill_rt("Sauce Contemplation"))  cs++;
        if(have_skill_rt("Nimble Fingers"))       cs++;
        if(have_skill_rt("Steal Accordion"))      cs++;
        tip(26,"Trivially Skilled","MODERATE","Perm level-0 skill from all 6 classes. Have "+cs+"/6. SC=Seal Clubbing Frenzy, TT=Headbutt, PM=Spaghetti Spear, S=Sauce Contemplation, DB=Nimble Fingers, AT=Steal Accordion.");
    }

    // ============================================================
    // SECTION 4 — GRIND
    // ============================================================
    section("GRIND - Long-Term Cumulative Progress", "#339966");

    if (!chk(38,"The Three Amigos"))
        tip(38,"The Three Amigos","GRIND","Donate 1M Meat to each of 3 Dungeoneers' Association statues (3M total).");

    if (!chk(56,"Crossroads"))
        tip(56,"Crossroads","GRIND","Use 50 scrolls of ancient forbidden unspeakable evil total (Cyrpt drops or mall).");

    if (!chk(57,"Friend of the Devils")) {
        int dem = get_property("demonSummons").to_int();
        tip(57,"Friend of the Devils","GRIND","Summon 30 demons total in Summoning Chamber. ~"+dem+" summons recorded.");
    }

    if (!chk(61,"Awwww, Yeah"))
        tip(61,"Awwww, Yeah","GRIND","Defeat 240 black puddings total (farm The Defiled Alcove in The Cyrpt).");

    if (!chk(67,"Brave Sir Robin"))
        tip(67,"Brave Sir Robin","GRIND","Successfully run away from 100 combats total.");

    if (!chk(62,"Phileas Foggy"))
        tip(62,"Phileas Foggy","GRIND","Drink 80 around the worlds total (coconut shell + all 5 spirits, advanced cocktailcrafting).");

    if (!chk(15,"Bouquet of Hippies"))
        tip(15,"Bouquet of Hippies","GRIND","Eat 420 piles of herb brownies total. Very long grind.");

    if (!chk(18,"Failure To Communicate"))
        tip(18,"Failure To Communicate","GRIND","Eat 50 Lucky Surprise Eggs total.");

    if (!chk(70,"Master Paster"))
        tip(70,"Master Paster","GRIND","Discover 69 Meat Pasting recipes. Systematically paste different item combos.");

    if (!chk(71,"Golden Spatula"))
        tip(71,"Golden Spatula","GRIND","Discover 50 different food recipes. Check Discoveries tab in Craft menu.");
    if (!chk(72,"Melon Baller, Shot Caller"))
        tip(72,"Melon Baller, Shot Caller","GRIND","Discover 100 different food recipes.");
    if (!chk(73,"BAM!"))
        tip(73,"BAM!","GRIND","Discover 150 different food recipes.");
    if (!chk(74,"Speakeasy Savant"))
        tip(74,"Speakeasy Savant","GRIND","Discover 20 different booze recipes.");
    if (!chk(75,"Honky Tonk Hero"))
        tip(75,"Honky Tonk Hero","GRIND","Discover 50 different booze recipes.");
    if (!chk(76,"Cantina Commander"))
        tip(76,"Cantina Commander","GRIND","Discover 100 different booze recipes.");
    if (!chk(77,"Apprentice Meatsmacker"))
        tip(77,"Apprentice Meatsmacker","GRIND","Discover 50 different meatsmithing recipes.");
    if (!chk(78,"Journeyman Meatsmacker"))
        tip(78,"Journeyman Meatsmacker","GRIND","Discover 100 different meatsmithing recipes.");
    if (!chk(79,"Master Meatsmacker"))
        tip(79,"Master Meatsmacker","GRIND","Discover 150 different meatsmithing recipes.");
    if (!chk(80,"Preciousss"))
        tip(80,"Preciousss","GRIND","Discover 30 different jewelrycrafting recipes.");
    if (!chk(92,"General Assembler"))
        tip(92,"General Assembler","GRIND","Discover 50 different miscellaneous recipes.");

    if (!chk(65,"Amateur Tour Guide"))
        tip(65,"Amateur Tour Guide","GRIND","Use 10 different familiars as 90-100% favorites across ascensions (check Ascension History).");
    if (!chk(66,"Professional Tour Guide"))
        tip(66,"Professional Tour Guide","GRIND","Use 30 different familiars as 90-100% favorites across ascensions.");
    if (!chk(33,"Slice and Dice"))
        tip(33,"Slice and Dice","GRIND","Use a Stab Bat as your 90-100% familiar for an entire ascension.");

    if (!chk(91,"Professional Photographer"))
        tip(91,"Professional Photographer","GRIND","Use 40 four-d cameras total (creates framed portraits).");
    if (!chk(95,"Who Hustles The Hustlers?"))
        tip(95,"Who Hustles The Hustlers?","GRIND","Beat Scratch Rackonteur at pool 23 times (Haunted Billiards Room).");
    if (!chk(96,"A Screw Ain't One"))
        tip(96,"A Screw Ain't One","GRIND","Kill 99 monsters with Loathing Legion hammer equipped. Keep it on while farming.");
    if (!chk(99,"Elf Barker"))
        tip(99,"Elf Barker","GRIND","Win 2000 lunar isotopes in Porko! (The Spacegate). Very long grind.");
    if (!chk(102,"Good Will Punching"))
        tip(102,"Good Will Punching","GRIND","Donate 1M Meat worth of items to charity.");
    if (!chk(117,"Horror Enthusiast"))
        tip(117,"Horror Enthusiast","GRIND","Collect all 30 Tales of Dread (Dreadsylvania books, some are rare drops).");

    if (!chk(120,"Kissing Maniac")) {
        int kisses = get_property("_dreadsylvaniaKisses").to_int();
        tip(120,"Kissing Maniac","GRIND","Gain 10000 kisses independently in Dreadsylvania (cumulative). ~"+kisses+" this session.");
    }

    if (!chk(130,"Gyro Hero"))
        tip(130,"Gyro Hero","GRIND","Eat 108 warbear gyros total (Crimbo content/mall).");
    if (!chk(6,"Silver Yeti"))
        tip(6,"Silver Yeti","GRIND","Win 10 fights with Yeti Protest Sign or faded red protest sign equipped.");
    if (!chk(7,"Golden Yeti"))
        tip(7,"Golden Yeti","GRIND","Win 100 fights with Yeti Protest Sign or faded red protest sign equipped.");
    if (!chk(29,"Friend of Elves"))
        tip(29,"Friend of Elves","GRIND","Win 10 fights with Unionize The Elves sign or faded green protest sign equipped.");
    if (!chk(30,"Reindeer Hunter"))
        tip(30,"Reindeer Hunter","GRIND","Win 100 fights with Unionize The Elves sign or faded green protest sign equipped.");
    if (!chk(40,"Best Meal of My Life"))
        tip(40,"Best Meal of My Life","GRIND","Consume 60 White Citadel burgers + 10 fries + 4 Cherry Cloaca + 4 Diet Cloaca total.");
    if (!chk(93,"Penultimate Fantasy VII"))
        tip(93,"Penultimate Fantasy VII","GRIND","Defeat 7 BRICKO airships total (build from BRICKO bricks).");
    if (!chk(101,"Hadouken!"))
        tip(101,"Hadouken!","GRIND","Deal 5000 damage in one Flying Fire Fist hit (Avatar of Boris). Stack all damage bonuses.");
    if (!chk(106,"Spirited Drinker"))
        tip(106,"Spirited Drinker","GRIND","Consume all 66 siphoned spirits total.");
    if (!chk(111,"The Old College Try"))
        tip(111,"The Old College Try","GRIND","Use 37 37x37x37 puzzle cubes total.");
    if (!chk(118,"Full Heart"))
        tip(118,"Full Heart","GRIND","Drink 50 bottles of Bloodweiser while Blood Porter is active (state-based, buy same session).");
    if (!chk(119,"Extended Capacity"))
        tip(119,"Extended Capacity","GRIND","Consume 50 glasses of electric Kool-Aid while Electric, Kool is active (state-based).");


    // ================================================================
    // SECTION 5a — MISSING STATE-BASED / COLLECTION TROPHIES
    // ================================================================
    if (!chk(19,"Tiny Plastic Trophy"))
        tip(19,"Tiny Plastic Trophy","GRIND","Have all 32 Tiny Plastic Series 1 figurines in your Display Case. Buy or farm from monsters.");
    if (!chk(69,"Two-Tiered Tiny Plastic Trophy"))
        tip(69,"Two-Tiered Tiny Plastic Trophy","GRIND","Have all 64 Tiny Plastic Series 2 figurines in your Display Case.");
    if (!chk(113,"Three-Tiered Tiny Plastic Trophy"))
        tip(113,"Three-Tiered Tiny Plastic Trophy","GRIND","Have all 32 Tiny Plastic Series 3 figurines in your Display Case.");
    if (!chk(97,"Had to Have Caught Them All"))
        tip(97,"Had to Have Caught Them All","GRIND","Have all 15 Pokemann figurines in your Display Case. Farm Dungeons of Doom or buy from mall.");
    if (!chk(108,"Fantastic Voyager"))
        tip(108,"Fantastic Voyager","GRIND","Have all 11 Microplushies in your Display Case (from Tales of Spelunking content).");
    if (!chk(83,"Hunter In Darkness"))
        tip(83,"Hunter In Darkness","GRIND","Kill 5 wumpii in a row without dying - state-based, buy immediately after the 5th kill.");
    if (!chk(90,"Septuple Platinum"))
        tip(90,"Septuple Platinum","GRIND","Make 7 unique Accordion Thief buff recordings in one day - state-based, buy same day.");
    if (!chk(103,"Moving Target"))
        tip(103,"Moving Target","GRIND","Roll a d12 exactly 1 higher than the last qualifying player. Check the forums for the current target number.");
    if (!chk(109,"Haggis Haggis Haggis Haggis Haggis"))
        tip(109,"Haggis Haggis Haggis Haggis Haggis","GRIND","Cast Haggis Kick wearing haggis socks + Mr. Haggis with Sheepskinned, Highland Sheen and Hagg-ard effects active.");
    if (!chk(110,"Now You've Tasted Everything"))
        tip(110,"Now You've Tasted Everything","GRIND","Have all 5 Magic Tongue effects active simultaneously - state-based, from the Magic Tongue item.");
    if (!chk(115,"Right Outfit, Wrong Place"))
        tip(115,"Right Outfit, Wrong Place","GRIND","Equip all at once: clown wig, spork, plush hamsterpus, giant gym membership card, white snakeskin duster, leotarrrd, Choker of the Ultragoth, oven mitts.");
    if (!chk(121,"Cruising For Six Bruisings"))
        tip(121,"Cruising For Six Bruisings","GRIND","Need First Blood Kiwi + Shepherd's Breath effects AND Ghost shawl + weedy skirt + Dreadsylvania Auditor's badge + moon-amber necklace equipped simultaneously.");
    if (!chk(127,"True Believer"))
        tip(127,"True Believer","GRIND","Have all 12 disco horoscope effects active simultaneously - state-based. Requires zodiac-themed items from the Gnomad Camp area.");
    if (!chk(139,"Omni-Cosplay"))
        tip(139,"Omni-Cosplay","GRIND","Equip returned Thinknerd package items: crying statue earrings, Gary Claybender's Time Screwer, plastic Duskwalker necklace, plastic replica blaster pistol, Space Tourist palmdoctor.");
    if (!chk(165,"Zoo Graft-on"))
        tip(165,"Zoo Graft-on","GRIND","Attach all 11 Z is for Zootomist familiars to your body - state-based, from Zootomist content.");
    if (!chk(166,"Mad Hattest"))
        tip(166,"Mad Hattest","GRIND","Equip 100+ hats simultaneously in Hat Trick - state-based. Requires Hat Trick skill and 100+ different hats.");

    // ================================================================
    // SECTION 5b — ASCENSION TROPHIES (require a dedicated run)
    // ================================================================
    section("ASCENSION - Requires a Dedicated Run", "#339966");
    print_html("<font color='#888888'><i>Plan these for a future run. Purchase BEFORE ascending (or before freeing King Ralph for hardcore ones marked *).</i></font>");

    if (!chk(1,"Little Boat"))    tip(1,"Little Boat","GRIND","Take 100 shore trips in a single ascension.");
    if (!chk(2,"Big Boat"))       tip(2,"Big Boat","GRIND","Take 1000 shore trips in a single ascension. Very adventure-intensive.");
    if (!chk(4,"100 Pound Load")) tip(4,"100 Pound Load","GRIND","Have familiars totalling 100 lbs in a single run.");
    if (!chk(5,"300 Pound Load")) tip(5,"300 Pound Load","GRIND","Have familiars totalling 300 lbs in a single run.");
    if (!chk(8,"Palindrophy"))    tip(8,"Palindrophy","GRIND","Build a Pagoda at campsite during a run (pagoda tat paper + stick of firewood).");
    if (!chk(14,"Easy Come Easy Go")) tip(14,"Easy Come Easy Go","GRIND","Discard a pretty flower (from A Fishing Hole) during a run.");
    if (!chk(16,"Weeping Pizza")) tip(16,"Weeping Pizza","GRIND","Eat 5 white chocolate and tomato pizzas in a single run.");
    if (!chk(17,"Black Hole Terrarium")) tip(17,"Black Hole Terrarium","GRIND","Have familiars totalling 500 lbs in a single run.");
    if (!chk(21,"Gadget Inspector")) tip(21,"Gadget Inspector","GRIND","Collect 10 clockwork keys from Thugnderdome in a single run.");
    if (!chk(22,"Boss Boss"))     tip(22,"Boss Boss","GRIND","Defeat all 4 main bosses with Super-Secret Canadian Mind-Control Device or Heartbreaker Hotel at 11, in one run.");
    if (!chk(24,"Gourdcore"))     tip(24,"Gourdcore","GRIND","* Defend the Gourd 20 times in a single hardcore run. Buy before freeing King Ralph!");
    if (!chk(25,"Let My Bugbears Go!")) tip(25,"Let My Bugbears Go!","GRIND","Receive the 'One Day in the Life' adventure (Big Brother in Felonia) during a run.");
    if (!chk(31,"Brass Bowling Trophy Trophy")) tip(31,"Brass Bowling Trophy Trophy","GRIND","Find the trophy on the mantel in the Strange Leaflet adventure during a run.");
    if (!chk(35,"Golden Meat Stack")) tip(35,"Golden Meat Stack","GRIND","* Obtain 1M Meat in a single hardcore run. Buy before freeing King Ralph!");
    if (!chk(41,"Scourge of Seals"))    tip(41,"Scourge of Seals","GRIND","Reach level 30 as a Seal Clubber in a single ascension.");
    if (!chk(42,"Tzar of Turtles"))     tip(42,"Tzar of Turtles","GRIND","Reach level 30 as a Turtle Tamer in a single ascension.");
    if (!chk(43,"Potentate of Pasta"))  tip(43,"Potentate of Pasta","GRIND","Reach level 30 as a Pastamancer in a single ascension.");
    if (!chk(44,"Sauciest Saucier"))    tip(44,"Sauciest Saucier","GRIND","Reach level 30 as a Sauceror in a single ascension.");
    if (!chk(45,"Duke of Disco"))       tip(45,"Duke of Disco","GRIND","Reach level 30 as a Disco Bandit in a single ascension.");
    if (!chk(46,"Maestro of Mariachi")) tip(46,"Maestro of Mariachi","GRIND","Reach level 30 as an Accordion Thief in a single ascension.");
    if (!chk(105,"And My Axe"))         tip(105,"And My Axe","GRIND","Reach level 30 as an Avatar of Boris in a single ascension.");
    if (!chk(114,"Cosmic Thing"))       tip(114,"Cosmic Thing","GRIND","Reach level 30 as an Avatar of Jarlsberg in a single ascension.");
    if (!chk(137,"Cool Guy"))           tip(137,"Cool Guy","GRIND","Reach level 30 as an Avatar of Sneaky Pete in a single ascension.");
    if (!chk(47,"The Butler Did It"))   tip(47,"The Butler Did It","GRIND","Use the Wizard of Ego quest reward 30 times in a single run.");
    if (!chk(48,"Slapstick"))           tip(48,"Slapstick","GRIND","Discard a banana peel and trigger the Schadenfreude adventure 3 times in one run.");
    if (!chk(50,"The Right Tool For The Job")) tip(50,"The Right Tool For The Job","GRIND","Spend 100 adventures in Haunted Bathroom with gnollish autoplunger equipped in one run.");
    if (!chk(58,"Bringer of Storms"))   tip(58,"Bringer of Storms","GRIND","Use 100 chaos butterflies in a single run.");
    if (!chk(60,"I Love A Parade"))     tip(60,"I Love A Parade","GRIND","Multi-use 11 handfuls of confetti in a single run.");
    if (!chk(63,"Extinctionist"))       tip(63,"Extinctionist","GRIND","Kill each Dungeon of Doom monster 120 times in a single run. Very adventure-heavy.");
    if (!chk(68,"Desert Wind"))         tip(68,"Desert Wind","GRIND","Multi-use 29 palm-frond fans in a single run.");
    if (!chk(81,"The One That Didn't Get Away")) tip(81,"The One That Didn't Get Away","GRIND","Defeat a Trophyfish during a run (fishing hole encounter).");
    if (!chk(84,"Evil's Okay in My Book")) tip(84,"Evil's Okay in My Book","GRIND","Become A Little Bit Evil OR use Perpetrate Mild Evil 13 times in a single run.");
    if (!chk(85,"A Little Help From My Friends")) tip(85,"A Little Help From My Friends","GRIND","Receive Cold-Blooded Warm Fuzzies buff 30 times in a single run.");
    if (!chk(86,"Dancing With the Stars")) tip(86,"Dancing With the Stars","GRIND","Use all 6 rave combos in a single fight during a run (Disco Bandit only).");
    if (!chk(88,"Spaghettihose"))       tip(88,"Spaghettihose","GRIND","Pastamancer: cast Canticle of Carboloading daily for 10 days, eating no pasta until day 10.");
    if (!chk(94,"The Wrong Place at the Right Time")) tip(94,"The Wrong Place at the Right Time","GRIND","Defeat nemeses in order SC->TT->P->S->DB->AT across 6 separate ascensions.");
    if (!chk(98,"Buzzkill"))            tip(98,"Buzzkill","GRIND","Wear 30 Bs in combat during a Bees Hate You challenge path run.");
    if (!chk(123,"Purity of Essence"))  tip(123,"Purity of Essence","GRIND","Join each high school clique (Moxie/Muscle/Mysticality), one per ascension (3 runs minimum).");
    if (!chk(151,"Tentacle Tickler"))   tip(151,"Tentacle Tickler","GRIND","Defeat 666 Eldritch Tentacles in a single ascension.");
    if (!chk(153,"Gelatinous Hubris"))  tip(153,"Gelatinous Hubris","GRIND","Learn all 125 Gelatinous Noob skills in a single ascension - state-based, buy before leaving that run.");
    if (!chk(163,"HIGH SCORE"))         tip(163,"HIGH SCORE","GRIND","Earn 100,000 points in the 8-Bit Realm in a single ascension.");

    // ============================================================
    // SECTION 6 — SEASONAL
    // ============================================================
    section("SEASONAL - Time-Limited Opportunities", "#777799");

    if (!chk(32,"Look, Ma! No Pants!"))
        tip(32,"Look, Ma! No Pants!","SEASONAL","New Year's Day only - no pants equipped on Jan 1st. Remember each year!");
    if (!chk(39,"Festive Dismemberment"))
        tip(39,"Festive Dismemberment","SEASONAL","Use Knob Goblin firecracker on July 4th. Must be done during an ascension run.");
    if (!chk(158,"Traditional Crimbo"))
        tip(158,"Traditional Crimbo","SEASONAL","Eat primitive candy cane + runny fermented egg + oldcake in same day (Crimbo). State-based - buy same day.");
    if (!chk(159,"Steak and a Beer, Eh?"))
        tip(159,"Steak and a Beer, Eh?","SEASONAL","Eat grilled mooseflank + drink antique beer in same day. Special event items.");
    if (!chk(161,"Yule Have a Headache Tomorrow"))
        tip(161,"Yule Have a Headache Tomorrow","SEASONAL","Drink 11 marshmallow bombs in one day (Crimbo only). State-based - buy same day.");
    if (!chk(164,"Ultimate Tosser"))
        tip(164,"Ultimate Tosser","SEASONAL","Throw the most water balloons yesterday (seasonal event).");

    // ============================================================
    // SECTION 7 — UNOBTAINABLE
    // ============================================================
    section("UNOBTAINABLE", "#555566");
    if (!chk(27,"This Lousy Trophy")) tip(27,"This Lousy Trophy","SKIP","Available June 9 2005 only. Gone forever.");
    tip(145,"(Trophy #145)","SKIP","Dev confirmed: not currently acquirable.");

    // ============================================================
    // SUMMARY
    // ============================================================
    print_html("");
    section("SUMMARY", "#ccaa00");
    print_html("<b>Owned:          </b><font color='#ccaa00'>" + G_HAVE + "</font>");
    print_html("<b>Ready to buy:   </b><font color='#ccaa00'>" + G_READY + "</font>  &lt;-- visit Trophy Hut NOW");
    print_html("<b>Easy wins:      </b><font color='#9944cc'>" + G_EASY + "</font>");
    print_html("<b>Moderate:       </b><font color='#4477cc'>" + G_MOD + "</font>");
    print_html("<b>Grind/Run:      </b><font color='#226644'>" + G_HARD + "</font>");
    print_html("<b>Unobtainable:   </b><font color='#555566'>" + G_SKIP + "</font>");
    print_html("");
    print_html("<font color='#666666'>Usage: ash trophy_advisor.ash [verbose | all]</font>");
    print_html("<font color='#555555'>Wiki: https://kol.coldfront.net/thekolwiki/index.php/Trophies</font>");
}
