Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-co1nam03on0075.outbound.protection.outlook.com ([104.47.40.75]:52128
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726598AbeG3Lrw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Jul 2018 07:47:52 -0400
From: Manish Narani <MNARANI@xilinx.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Sai Krishna Potthuri <lakshmis@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        Anirudha Sarangi <anirudh@xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] iio: adc: xilinx: limit pcap clock frequency value
Date: Mon, 30 Jul 2018 10:13:26 +0000
Message-ID: <SN6PR02MB495915F6DDEC42F4F44DB13BC12F0@SN6PR02MB4959.namprd02.prod.outlook.com>
References: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
        <1532358123-23485-3-git-send-email-manish.narani@xilinx.com>
 <20180729125106.05692a44@archlinux>
In-Reply-To: <20180729125106.05692a44@archlinux>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,


> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: Sunday, July 29, 2018 5:21 PM
> To: Manish Narani <MNARANI@xilinx.com>
> Cc: Sai Krishna Potthuri <lakshmis@xilinx.com>; Michal Simek
> <michals@xilinx.com>; pmeerw@pmeerw.net; lars@metafoo.de;
> knaack.h@gmx.de; Anirudha Sarangi <anirudh@xilinx.com>; Srinivas Goud
> <sgoud@xilinx.com>; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-iio@vger.kernel.org
> Subject: Re: [PATCH v2 2/4] iio: adc: xilinx: limit pcap clock frequency =
value
>=20
> On Mon, 23 Jul 2018 20:32:01 +0530
> Manish Narani <manish.narani@xilinx.com> wrote:
>=20
> > This patch limits the xadc pcap clock frequency value to be less than
> > 200MHz. This fixes the issue when zynq is booted at higher frequency
> > values, pcap crosses the maximum limit of 200MHz(Fmax) as it is
> > derived from IOPLL.
> > If this limit is crossed it is required to alter the WEDGE and REDGE
> > bits of XADC_CFG register to make timings better in the interface. So
> > to avoid alteration of these bits every time, the pcap value should
> > not cross the Fmax limit.
> >
> > Signed-off-by: Manish Narani <manish.narani@xilinx.com>
>=20
> Applied, to the togreg branch of iio.git.  If you want this backported to=
 stable,
> then request it once this patch is upstream.  It may be sometime given we=
've
> probably just missed the coming merge window.
>=20
> If you do need it faster then let me know and I'll look at moving it over=
 to the
> branch of fixes during the RC phases.
Thanks for getting this applied. There is no concern for this to be in the =
stable
ASAP. I can wait.

Thanks & Regards,
Manish Narani
