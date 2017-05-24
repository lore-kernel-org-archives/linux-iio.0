Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754614AbdEXTlP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 May 2017 15:41:15 -0400
Date: Wed, 24 May 2017 20:41:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, kbuild-all@01.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: cpcap: Fix default register values and
 battery temperature (fwd)
Message-ID: <20170524204110.1f2400d3@kernel.org>
In-Reply-To: <20170524154612.GZ10472@atomide.com>
References: <alpine.DEB.2.20.1705240938520.2983@hadrien>
        <20170524154612.GZ10472@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 24 May 2017 08:46:12 -0700
Tony Lindgren <tony@atomide.com> wrote:

> Hi,
> 
> * Julia Lawall <julia.lawall@lip6.fr> [170524 00:43]:
> > CPCAP_BIT_ADTRIG_DIS is duplicated on lines 77-82.
> > 02e16000 Tony Lindgren 2017-05-22  77  #define CPCAP_REG_ADCC2_DEFAULTS	(CPCAP_BIT_AD4_SELECT | \
> > 02e16000 Tony Lindgren 2017-05-22 @78  					 CPCAP_BIT_ADTRIG_DIS | \
> > 02e16000 Tony Lindgren 2017-05-22  79  					 CPCAP_BIT_ADTRIG_DIS | \  
> 
> Oops, thanks for letting me know.
> 
> Jonathan, do you want an incremental patch or v3 of the whole set resent?
> 
> Regards,
> 
> Tony

Fixed up and repushed out.  Thanks

Jonathan
