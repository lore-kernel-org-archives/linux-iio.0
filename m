Return-Path: <SRS0=YgUj=BE=verge.net.au=horms@kernel.org>
Date: Thu, 5 Oct 2017 11:12:59 +0200
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: rcar-gyroadc: Use
 of_device_get_match_data() helper
Message-ID: <20171005091258.GK26369@verge.net.au>
References: <1507118906-8946-1-git-send-email-geert+renesas@glider.be>
 <1507118906-8946-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1507118906-8946-4-git-send-email-geert+renesas@glider.be>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Oct 04, 2017 at 02:08:26PM +0200, Geert Uytterhoeven wrote:
> Use the of_device_get_match_data() helper instead of open coding.
> Note that the rcar-gyroadc driver is used with DT only, so there's
> always a valid match.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
