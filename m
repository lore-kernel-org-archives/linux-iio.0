Return-Path: <SRS0=LZr/=46=atomide.com=tony@kernel.org>
Date: Wed, 24 May 2017 08:46:12 -0700
From: Tony Lindgren <tony@atomide.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Jonathan Cameron <jic23@kernel.org>, kbuild-all@01.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
	Marcel Partap <mpartap@gmx.net>,
	Michael Scott <michael.scott@linaro.org>,
	Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: cpcap: Fix default register values and
 battery temperature (fwd)
Message-ID: <20170524154612.GZ10472@atomide.com>
References: <alpine.DEB.2.20.1705240938520.2983@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1705240938520.2983@hadrien>
List-ID: <linux-iio@vger.kernel.org>

Hi,

* Julia Lawall <julia.lawall@lip6.fr> [170524 00:43]:
> CPCAP_BIT_ADTRIG_DIS is duplicated on lines 77-82.
> 02e16000 Tony Lindgren 2017-05-22  77  #define CPCAP_REG_ADCC2_DEFAULTS	(CPCAP_BIT_AD4_SELECT | \
> 02e16000 Tony Lindgren 2017-05-22 @78  					 CPCAP_BIT_ADTRIG_DIS | \
> 02e16000 Tony Lindgren 2017-05-22  79  					 CPCAP_BIT_ADTRIG_DIS | \

Oops, thanks for letting me know.

Jonathan, do you want an incremental patch or v3 of the whole set resent?

Regards,

Tony
