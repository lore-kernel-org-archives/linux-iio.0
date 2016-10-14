Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hosting.pavoucek.net ([46.28.107.168]:43936 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754471AbcJNMYc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Oct 2016 08:24:32 -0400
Date: Fri, 14 Oct 2016 14:24:23 +0200
From: Tomas Novotny <tomas@novotny.cz>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Yong Li <sdliyong@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: dac: mcp4725: use regulator framework
Message-ID: <20161014142423.005b3108@tomas>
In-Reply-To: <87088906-8986-cca0-c29a-747610bae982@metafoo.de>
References: <1476194263-12015-1-git-send-email-tomas@novotny.cz>
        <1476194263-12015-2-git-send-email-tomas@novotny.cz>
        <87088906-8986-cca0-c29a-747610bae982@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On Fri, 14 Oct 2016 13:58:24 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 10/11/2016 03:57 PM, Tomas Novotny wrote:
> 
> Hi,
> 
> Looks mostly good. One small thing that should be addressed.
> 
> > diff --git a/include/linux/iio/dac/mcp4725.h
> > b/include/linux/iio/dac/mcp4725.h index 91530e6..7c062e8 100644
> > --- a/include/linux/iio/dac/mcp4725.h
> > +++ b/include/linux/iio/dac/mcp4725.h
> > @@ -10,7 +10,6 @@
> >  #define IIO_DAC_MCP4725_H_
> >  
> >  struct mcp4725_platform_data {
> > -	u16 vref_mv;
> >  };
> 
> Might as well remove the whole struct and file and drop the if (!pdata)
> check in the driver probe function. Having to declare a empty platform_data
> for the driver to work is not that sensible.

Yes, I was thinking of it but I left the empty structure in the driver
finally (I briefly comment it also in the commit message of this patch). The
reason is that the structure is used again in the next commit. So removing
the file and associated checks and putting it back again would make
unnecessary noise in the patches. Anyway, if you think that it is really
needed I will do it.

Thanks,

Tomas

> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
