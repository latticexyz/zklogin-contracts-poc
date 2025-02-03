// SPDX-License-Identifier: GPL-3.0
/*
    Copyright 2021 0KIMS association.

    This file is generated with [snarkJS](https://github.com/iden3/snarkjs).

    snarkJS is a free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    snarkJS is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
    or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public
    License for more details.

    You should have received a copy of the GNU General Public License
    along with snarkJS. If not, see <https://www.gnu.org/licenses/>.
*/

pragma solidity >=0.7.0 <0.9.0;

import {console} from "forge-std/Test.sol";

contract JwtGroth16Verifier {
    // Scalar field size
    uint256 constant r = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
    // Base field size
    uint256 constant q = 21888242871839275222246405745257275088696311157297823662689037894645226208583;

    // Verification Key data
    uint256 constant alphax = 20491192805390485299153009773594534940189261866228447918068658471970481763042;
    uint256 constant alphay = 9383485363053290200918347156157836566562967994039712273449902621266178545958;
    uint256 constant betax1 = 4252822878758300859123897981450591353533073413197771768651442665752259397132;
    uint256 constant betax2 = 6375614351688725206403948262868962793625744043794305715222011528459656738731;
    uint256 constant betay1 = 21847035105528745403288232691147584728191162732299865338377159692350059136679;
    uint256 constant betay2 = 10505242626370262277552901082094356697409835680220590971873171140371331206856;
    uint256 constant gammax1 = 11559732032986387107991004021392285783925812861821192530917403151452391805634;
    uint256 constant gammax2 = 10857046999023057135944570762232829481370756359578518086990519993285655852781;
    uint256 constant gammay1 = 4082367875863433681332203403145435568316851327593401208105741076214120093531;
    uint256 constant gammay2 = 8495653923123431417604973247489272438418190587263600148770280649306958101930;
    uint256 constant deltax1 = 11559732032986387107991004021392285783925812861821192530917403151452391805634;
    uint256 constant deltax2 = 10857046999023057135944570762232829481370756359578518086990519993285655852781;
    uint256 constant deltay1 = 4082367875863433681332203403145435568316851327593401208105741076214120093531;
    uint256 constant deltay2 = 8495653923123431417604973247489272438418190587263600148770280649306958101930;

    uint256 constant IC0x = 10479798727520319882413932955794397442740607545627023626110862115830060018729;
    uint256 constant IC0y = 13173811609443364746998380539774680825545463033152851914558798223666332404486;

    uint256 constant IC1x = 4195965768892197278332988912450264894292458234333210696597087936794641321442;
    uint256 constant IC1y = 16399562449549551487266965102949581244342222870729436514089262813108517548355;

    uint256 constant IC2x = 6330009816213563011247686848779098603884159022407659076497010604930293549680;
    uint256 constant IC2y = 18100590767384298632835525009027626890223860352882345215272747055089980471004;

    uint256 constant IC3x = 5773243970246679650984742099473001508022688484198096745984494444177127645751;
    uint256 constant IC3y = 17430467783884699180253940885512505279490028823014155785283772929202326443061;

    uint256 constant IC4x = 16678390577391783242847826751510900094670942162805360014318531691377954945759;
    uint256 constant IC4y = 13644605789962912946479939303049630520887107950735366643689333942723244182294;

    uint256 constant IC5x = 14920832341737538375831160466287053132120287162027433843850671142253790459612;
    uint256 constant IC5y = 18391002054301378250175220323590682242465161312428853616306516734207628585640;

    uint256 constant IC6x = 2510090026502434741639701399001566610017862580710151679026689204430794049878;
    uint256 constant IC6y = 13062458266574273047969698152968285469083602878729533082622288058918147073373;

    uint256 constant IC7x = 16919856680409586792561417758403405311351493031463355111681484920151208300453;
    uint256 constant IC7y = 14947675414304615708461969981945333340556751573174469757341795170084856338457;

    uint256 constant IC8x = 16522342560635243142585348017029247501476883797660568782038132051245374143549;
    uint256 constant IC8y = 6697354810736357342946926154282302574144165001742660615965286696407196044750;

    uint256 constant IC9x = 19393133793922201847608510931645031620053501624674111022247785648881040224159;
    uint256 constant IC9y = 302833541263910501014845617805428821258798320951507876648898651402222853053;

    uint256 constant IC10x = 8638294315753429657135327043672880472235201830964268848432820372780327661657;
    uint256 constant IC10y = 16140217225673683514991596924704932888092487797133026851493131033139272977135;

    uint256 constant IC11x = 129164595660739042752825144384447936678364190164319125725547701131647857295;
    uint256 constant IC11y = 21611694783520570029319773699098261526055367602140053793129303485274544700393;

    uint256 constant IC12x = 15034615378609921183979194491287319680431906936451174230726864501841851213838;
    uint256 constant IC12y = 2105875779214540039258736249253250576810058542942727156678757969949315457439;

    uint256 constant IC13x = 21724016589826494944127017963964509842895249045700525245918559439600674446876;
    uint256 constant IC13y = 7766669804380806375539347877476901769000902582778636666976007911286757780173;

    uint256 constant IC14x = 8024535315141486735024527159191782185538634510477166016038516548761540755371;
    uint256 constant IC14y = 5056450280526557511785911728474371378561973524071790478028852361957630990915;

    uint256 constant IC15x = 2191892566692463190799710376492061891159069937575208073924739838253702887988;
    uint256 constant IC15y = 7401000539482595677954781539783365182149154126250608546030806995731932176139;

    uint256 constant IC16x = 20699363290349695033660016696444549021652822457418301349465744063904575087012;
    uint256 constant IC16y = 6256750349708843826351304238213527565564138937329061408548314216200365645217;

    uint256 constant IC17x = 10365602954135089019532256116967237089600491628391332066153414732843054264003;
    uint256 constant IC17y = 3523438251145154331036095603044818765723045808713353760473322649508323630757;

    uint256 constant IC18x = 13979170437896743716064292240039938058383537146650156308934370947740752348265;
    uint256 constant IC18y = 1929239880579139693364112748853335647008299815114008548025304683863592451536;

    uint256 constant IC19x = 1856395209194422404172624825299586147270420568258113034169234665660924628120;
    uint256 constant IC19y = 3260813929025840093022488335808152531638315888493953755723678453016235333042;

    uint256 constant IC20x = 12904212158997398874539965408180175153140734143463278876855637610353413682045;
    uint256 constant IC20y = 5692338162222784097302252964286323954046855809260530205456262868832570800488;

    uint256 constant IC21x = 20050391871748171512515507661566114582982565189360916593600774506518833041416;
    uint256 constant IC21y = 7741084654383574098210674781452589204106701736102707950297655633203625488212;

    uint256 constant IC22x = 11054476255434816217603734007219988212685448777569430962458086637844583358367;
    uint256 constant IC22y = 3156029687952245178707831159658188170972658613414439241245088178119211714464;

    uint256 constant IC23x = 15282468284730586118826818453122664215083125396707434402914853589237656664633;
    uint256 constant IC23y = 270981946527216747336743966986841858809370844207658736236076186568352953844;

    uint256 constant IC24x = 15503356526445044962141557185825319315588325996185428844771959241894478072757;
    uint256 constant IC24y = 14849345238474451625952526734022809310954447130347516873070241187340968795046;

    uint256 constant IC25x = 10555164399192618734634297226762648877325127893383678841858917903922159195608;
    uint256 constant IC25y = 16692334669080918715044769106448191145011646025247385231641872279914948145107;

    uint256 constant IC26x = 17804788339711899552601493576701270883110271091561609534430521982948671260738;
    uint256 constant IC26y = 12954737943149172539077463291656604316960899012008404047394626831908725964275;

    uint256 constant IC27x = 9368697410296200139106739385213290215971276626411196827627662381873472860211;
    uint256 constant IC27y = 15847803626605744581211624310774845618566028151166316504787337992763727449488;

    uint256 constant IC28x = 7870569481674669098937589707343712964639310510652309734111660147340577990448;
    uint256 constant IC28y = 13730101407546792318782679416569387354312239696275180147842384875784766142216;

    uint256 constant IC29x = 11062588290541615568951817779323394965575426686024679580446557830142109674625;
    uint256 constant IC29y = 8836521061572622951188948093432030361463554264119398254601249001551996367273;

    uint256 constant IC30x = 12768425295164957728566302098384706188742105384905575301347482826041780069498;
    uint256 constant IC30y = 10819592983243727983961307841007280035554839295781718124908519262316437917222;

    uint256 constant IC31x = 8954831316006793418880094210007342676257956178616661139787659128191408999962;
    uint256 constant IC31y = 21852583632992313575801784380226908326752285161965377486933261853357362063578;

    uint256 constant IC32x = 3450108813159543055887805910470463590526922651006752337966714211064362481583;
    uint256 constant IC32y = 14466896353287775523768456324121473983396836262939803511024127447249649002010;

    uint256 constant IC33x = 6505629988187624456444754531546327840136031479135079960326885800269484601547;
    uint256 constant IC33y = 2496598073010096258148749951856632121455599329117475886290476773029968805854;

    uint256 constant IC34x = 3809528914923887753802677892093388176752751223381926213655854865226864071809;
    uint256 constant IC34y = 6797217456110201762009673345290964321980798085843761981391322305045274194553;

    uint256 constant IC35x = 2251463332226657543832491971061462615009309210680875670022821939669327753950;
    uint256 constant IC35y = 2500531538051527863843778751662350131689442983577380721139278740144933533914;

    uint256 constant IC36x = 7844170037288961629893468067341988684192773797904267658967919241217418916301;
    uint256 constant IC36y = 3043855192032497389916433561721570205387948655373248457046481117044185104384;

    uint256 constant IC37x = 6339624343252109378521715222299299569344808822032817134943607793876215711980;
    uint256 constant IC37y = 4977120094217085208171767241476010045202452278730594581833974456488185352155;

    uint256 constant IC38x = 8280627982121133082777714510193183792142978788297951335464582063405566050278;
    uint256 constant IC38y = 5017087283881855196706252322081512571379810438859273120213053608787904034695;

    uint256 constant IC39x = 12471066869068205286920803145611948063072583469546856071296782671678423906652;
    uint256 constant IC39y = 12783716618132588975822567377781871491363289396873086922636720381785453524903;

    uint256 constant IC40x = 16692473029239866238907347531467365161278630007579276284942192581346903972454;
    uint256 constant IC40y = 11204410226628507320326581320720043844463424254456152755282940207834924640926;

    // Memory data
    uint16 constant pVk = 0;
    uint16 constant pPairing = 128;

    uint16 constant pLastMem = 896;

    function verifyProof(
        uint256[2] calldata _pA,
        uint256[2][2] calldata _pB,
        uint256[2] calldata _pC,
        uint256[40] calldata _pubSignals
    ) public view returns (bool) {
        assembly {
            function checkField(v) {
                if iszero(lt(v, r)) {
                    mstore(0, 0)
                    return(0, 0x20)
                }
            }

            // G1 function to multiply a G1 value(x,y) to value in an address
            function g1_mulAccC(pR, x, y, s) {
                let success
                let mIn := mload(0x40)
                mstore(mIn, x)
                mstore(add(mIn, 32), y)
                mstore(add(mIn, 64), s)

                success := staticcall(sub(gas(), 2000), 7, mIn, 96, mIn, 64)

                if iszero(success) {
                    mstore(0, 0)
                    return(0, 0x20)
                }

                mstore(add(mIn, 64), mload(pR))
                mstore(add(mIn, 96), mload(add(pR, 32)))

                success := staticcall(sub(gas(), 2000), 6, mIn, 128, pR, 64)

                if iszero(success) {
                    mstore(0, 0)
                    return(0, 0x20)
                }
            }

            function checkPairing(pA, pB, pC, pubSignals, pMem) -> isOk {
                let _pPairing := add(pMem, pPairing)
                let _pVk := add(pMem, pVk)

                mstore(_pVk, IC0x)
                mstore(add(_pVk, 32), IC0y)

                // Compute the linear combination vk_x

                g1_mulAccC(_pVk, IC1x, IC1y, calldataload(add(pubSignals, 0)))

                g1_mulAccC(_pVk, IC2x, IC2y, calldataload(add(pubSignals, 32)))

                g1_mulAccC(_pVk, IC3x, IC3y, calldataload(add(pubSignals, 64)))

                g1_mulAccC(_pVk, IC4x, IC4y, calldataload(add(pubSignals, 96)))

                g1_mulAccC(_pVk, IC5x, IC5y, calldataload(add(pubSignals, 128)))

                g1_mulAccC(_pVk, IC6x, IC6y, calldataload(add(pubSignals, 160)))

                g1_mulAccC(_pVk, IC7x, IC7y, calldataload(add(pubSignals, 192)))

                g1_mulAccC(_pVk, IC8x, IC8y, calldataload(add(pubSignals, 224)))

                g1_mulAccC(_pVk, IC9x, IC9y, calldataload(add(pubSignals, 256)))

                g1_mulAccC(_pVk, IC10x, IC10y, calldataload(add(pubSignals, 288)))

                g1_mulAccC(_pVk, IC11x, IC11y, calldataload(add(pubSignals, 320)))

                g1_mulAccC(_pVk, IC12x, IC12y, calldataload(add(pubSignals, 352)))

                g1_mulAccC(_pVk, IC13x, IC13y, calldataload(add(pubSignals, 384)))

                g1_mulAccC(_pVk, IC14x, IC14y, calldataload(add(pubSignals, 416)))

                g1_mulAccC(_pVk, IC15x, IC15y, calldataload(add(pubSignals, 448)))

                g1_mulAccC(_pVk, IC16x, IC16y, calldataload(add(pubSignals, 480)))

                g1_mulAccC(_pVk, IC17x, IC17y, calldataload(add(pubSignals, 512)))

                g1_mulAccC(_pVk, IC18x, IC18y, calldataload(add(pubSignals, 544)))

                g1_mulAccC(_pVk, IC19x, IC19y, calldataload(add(pubSignals, 576)))

                g1_mulAccC(_pVk, IC20x, IC20y, calldataload(add(pubSignals, 608)))

                g1_mulAccC(_pVk, IC21x, IC21y, calldataload(add(pubSignals, 640)))

                g1_mulAccC(_pVk, IC22x, IC22y, calldataload(add(pubSignals, 672)))

                g1_mulAccC(_pVk, IC23x, IC23y, calldataload(add(pubSignals, 704)))

                g1_mulAccC(_pVk, IC24x, IC24y, calldataload(add(pubSignals, 736)))

                g1_mulAccC(_pVk, IC25x, IC25y, calldataload(add(pubSignals, 768)))

                g1_mulAccC(_pVk, IC26x, IC26y, calldataload(add(pubSignals, 800)))

                g1_mulAccC(_pVk, IC27x, IC27y, calldataload(add(pubSignals, 832)))

                g1_mulAccC(_pVk, IC28x, IC28y, calldataload(add(pubSignals, 864)))

                g1_mulAccC(_pVk, IC29x, IC29y, calldataload(add(pubSignals, 896)))

                g1_mulAccC(_pVk, IC30x, IC30y, calldataload(add(pubSignals, 928)))

                g1_mulAccC(_pVk, IC31x, IC31y, calldataload(add(pubSignals, 960)))

                g1_mulAccC(_pVk, IC32x, IC32y, calldataload(add(pubSignals, 992)))

                g1_mulAccC(_pVk, IC33x, IC33y, calldataload(add(pubSignals, 1024)))

                g1_mulAccC(_pVk, IC34x, IC34y, calldataload(add(pubSignals, 1056)))

                g1_mulAccC(_pVk, IC35x, IC35y, calldataload(add(pubSignals, 1088)))

                g1_mulAccC(_pVk, IC36x, IC36y, calldataload(add(pubSignals, 1120)))

                g1_mulAccC(_pVk, IC37x, IC37y, calldataload(add(pubSignals, 1152)))

                g1_mulAccC(_pVk, IC38x, IC38y, calldataload(add(pubSignals, 1184)))

                g1_mulAccC(_pVk, IC39x, IC39y, calldataload(add(pubSignals, 1216)))

                g1_mulAccC(_pVk, IC40x, IC40y, calldataload(add(pubSignals, 1248)))

                // -A
                mstore(_pPairing, calldataload(pA))
                mstore(add(_pPairing, 32), mod(sub(q, calldataload(add(pA, 32))), q))

                // B
                mstore(add(_pPairing, 64), calldataload(pB))
                mstore(add(_pPairing, 96), calldataload(add(pB, 32)))
                mstore(add(_pPairing, 128), calldataload(add(pB, 64)))
                mstore(add(_pPairing, 160), calldataload(add(pB, 96)))

                // alpha1
                mstore(add(_pPairing, 192), alphax)
                mstore(add(_pPairing, 224), alphay)

                // beta2
                mstore(add(_pPairing, 256), betax1)
                mstore(add(_pPairing, 288), betax2)
                mstore(add(_pPairing, 320), betay1)
                mstore(add(_pPairing, 352), betay2)

                // vk_x
                mstore(add(_pPairing, 384), mload(add(pMem, pVk)))
                mstore(add(_pPairing, 416), mload(add(pMem, add(pVk, 32))))

                // gamma2
                mstore(add(_pPairing, 448), gammax1)
                mstore(add(_pPairing, 480), gammax2)
                mstore(add(_pPairing, 512), gammay1)
                mstore(add(_pPairing, 544), gammay2)

                // C
                mstore(add(_pPairing, 576), calldataload(pC))
                mstore(add(_pPairing, 608), calldataload(add(pC, 32)))

                // delta2
                mstore(add(_pPairing, 640), deltax1)
                mstore(add(_pPairing, 672), deltax2)
                mstore(add(_pPairing, 704), deltay1)
                mstore(add(_pPairing, 736), deltay2)

                let success := staticcall(sub(gas(), 2000), 8, _pPairing, 768, _pPairing, 0x20)

                isOk := and(success, mload(_pPairing))
            }

            let pMem := mload(0x40)
            mstore(0x40, add(pMem, pLastMem))

            // Validate that all evaluations ∈ F

            checkField(calldataload(add(_pubSignals, 0)))

            checkField(calldataload(add(_pubSignals, 32)))

            checkField(calldataload(add(_pubSignals, 64)))

            checkField(calldataload(add(_pubSignals, 96)))

            checkField(calldataload(add(_pubSignals, 128)))

            checkField(calldataload(add(_pubSignals, 160)))

            checkField(calldataload(add(_pubSignals, 192)))

            checkField(calldataload(add(_pubSignals, 224)))

            checkField(calldataload(add(_pubSignals, 256)))

            checkField(calldataload(add(_pubSignals, 288)))

            checkField(calldataload(add(_pubSignals, 320)))

            checkField(calldataload(add(_pubSignals, 352)))

            checkField(calldataload(add(_pubSignals, 384)))

            checkField(calldataload(add(_pubSignals, 416)))

            checkField(calldataload(add(_pubSignals, 448)))

            checkField(calldataload(add(_pubSignals, 480)))

            checkField(calldataload(add(_pubSignals, 512)))

            checkField(calldataload(add(_pubSignals, 544)))

            checkField(calldataload(add(_pubSignals, 576)))

            checkField(calldataload(add(_pubSignals, 608)))

            checkField(calldataload(add(_pubSignals, 640)))

            checkField(calldataload(add(_pubSignals, 672)))

            checkField(calldataload(add(_pubSignals, 704)))

            checkField(calldataload(add(_pubSignals, 736)))

            checkField(calldataload(add(_pubSignals, 768)))

            checkField(calldataload(add(_pubSignals, 800)))

            checkField(calldataload(add(_pubSignals, 832)))

            checkField(calldataload(add(_pubSignals, 864)))

            checkField(calldataload(add(_pubSignals, 896)))

            checkField(calldataload(add(_pubSignals, 928)))

            checkField(calldataload(add(_pubSignals, 960)))

            checkField(calldataload(add(_pubSignals, 992)))

            checkField(calldataload(add(_pubSignals, 1024)))

            checkField(calldataload(add(_pubSignals, 1056)))

            checkField(calldataload(add(_pubSignals, 1088)))

            checkField(calldataload(add(_pubSignals, 1120)))

            checkField(calldataload(add(_pubSignals, 1152)))

            checkField(calldataload(add(_pubSignals, 1184)))

            checkField(calldataload(add(_pubSignals, 1216)))

            checkField(calldataload(add(_pubSignals, 1248)))

            // Validate all evaluations
            let isValid := checkPairing(_pA, _pB, _pC, _pubSignals, pMem)

            mstore(0, isValid)
            return(0, 0x20)
        }
    }
}
