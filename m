Return-Path: <pmeerw@pmeerw.net>
Date: Sun, 11 Sep 2016 20:47:32 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org, Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [PATCH] iio: Add driver for Silabs si1132, si1141/2/3 and
 si1145/6/7 ambient light, uv index and proximity sensors
In-Reply-To: <1473618949-17534-1-git-send-email-pmeerw@pmeerw.net>
Message-ID: <alpine.DEB.2.02.1609112044550.28464@pmeerw.net>
References: <1473618949-17534-1-git-send-email-pmeerw@pmeerw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


On Sun, 11 Sep 2016, Peter Meerwald-Stadler wrote:

> The si114x supports x=1,2,3 IR LEDs for proximity sensing together with
> visible and IR ambient light sensing (ALS).
> Newer parts (si1132, si1145/6/7) can measure UV light and compute an UV
> index
> 
> Changes since v3:
> * Don't set .owner to address kbuild warning

please disregard and use mail with "PATCH v4" subject, sorry

thx, p.

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
