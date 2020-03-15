<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="kintex7" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="m_axis_rx_tvalid" />
        <signal name="user_clk" />
        <signal name="m_axis_rx_tlast" />
        <signal name="VCC" />
        <signal name="trn_rsof" />
        <port polarity="Input" name="m_axis_rx_tvalid" />
        <port polarity="Input" name="user_clk" />
        <port polarity="Input" name="m_axis_rx_tlast" />
        <port polarity="Input" name="VCC" />
        <port polarity="Output" name="trn_rsof" />
        <blockdef name="fdre">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-192" y2="-192" x1="0" />
            <line x2="64" y1="-256" y2="-256" x1="0" />
            <line x2="320" y1="-256" y2="-256" x1="384" />
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <rect width="256" x="64" y="-320" height="256" />
            <line x2="192" y1="-64" y2="-32" x1="192" />
            <line x2="64" y1="-32" y2="-32" x1="192" />
            <line x2="80" y1="-112" y2="-128" x1="64" />
            <line x2="64" y1="-128" y2="-144" x1="80" />
        </blockdef>
        <block symbolname="fdre" name="XLXI_3">
            <blockpin signalname="user_clk" name="C" />
            <blockpin signalname="m_axis_rx_tvalid" name="CE" />
            <blockpin signalname="VCC" name="D" />
            <blockpin signalname="m_axis_rx_tlast" name="R" />
            <blockpin signalname="trn_rsof" name="Q" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="912" y="1520" name="XLXI_3" orien="R0" />
        <branch name="m_axis_rx_tvalid">
            <wire x2="912" y1="1328" y2="1328" x1="896" />
        </branch>
        <branch name="user_clk">
            <wire x2="896" y1="1392" y2="1392" x1="800" />
            <wire x2="912" y1="1392" y2="1392" x1="896" />
        </branch>
        <branch name="m_axis_rx_tlast">
            <wire x2="912" y1="1488" y2="1488" x1="896" />
        </branch>
        <branch name="VCC">
            <wire x2="896" y1="1264" y2="1264" x1="752" />
            <wire x2="912" y1="1264" y2="1264" x1="896" />
        </branch>
        <branch name="trn_rsof">
            <wire x2="1312" y1="1264" y2="1264" x1="1296" />
            <wire x2="1328" y1="1264" y2="1264" x1="1312" />
        </branch>
        <iomarker fontsize="28" x="896" y="1488" name="m_axis_rx_tlast" orien="R180" />
        <iomarker fontsize="28" x="1328" y="1264" name="trn_rsof" orien="R0" />
        <iomarker fontsize="28" x="800" y="1392" name="user_clk" orien="R180" />
        <iomarker fontsize="28" x="896" y="1328" name="m_axis_rx_tvalid" orien="R180" />
        <iomarker fontsize="28" x="752" y="1264" name="VCC" orien="R180" />
    </sheet>
</drawing>