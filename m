Return-Path: <SRS0=Bw5b=5Y=pmeerw.net=pmeerw@kernel.org>
Date: Mon, 19 Jun 2017 17:10:53 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Olivier Dugas <olivier.dugas.1@gmail.com>
cc: jic23@kernel.org, leonard.crestez@intel.com, linux-iio@vger.kernel.org
Subject: Re: SI1133 light sensor: Is there anything to refer to?
In-Reply-To: <938fc03d-63d9-de58-d536-de1cd51c732d@gmail.com>
Message-ID: <alpine.DEB.2.20.1706191652040.15475@vps.pmeerw.net>
References: <938fc03d-63d9-de58-d536-de1cd51c732d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello Olivier,

> We've recently been trying to make the SI1133 light sensor work according to
> what's written in its datasheet. Unfortunately many questions remain and the
> si1145.c driver seems largely different from si1133. We believe that any code
> sample would be of a great help. Are you aware of any driver, unmerged patch
> or other code sample for this sensor?

the si1133 belongs in the same family as the si1153 which has a different 
register layout than the previous chips, so I think a separate driver is 
needed

I do have an eval board for the si1153 and started a driver, but it's not 
ready for submission (yet), the si1133 should be a lot simpler than the 
si1153

regards, p.

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
