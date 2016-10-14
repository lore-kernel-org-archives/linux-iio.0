Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:50537 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754171AbcJNL63 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Oct 2016 07:58:29 -0400
Subject: Re: [PATCH v2 1/4] iio: dac: mcp4725: use regulator framework
To: Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org
References: <1476194263-12015-1-git-send-email-tomas@novotny.cz>
 <1476194263-12015-2-git-send-email-tomas@novotny.cz>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Yong Li <sdliyong@gmail.com>, linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <87088906-8986-cca0-c29a-747610bae982@metafoo.de>
Date: Fri, 14 Oct 2016 13:58:24 +0200
MIME-Version: 1.0
In-Reply-To: <1476194263-12015-2-git-send-email-tomas@novotny.cz>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/11/2016 03:57 PM, Tomas Novotny wrote:

Hi,

Looks mostly good. One small thing that should be addressed.

> diff --git a/include/linux/iio/dac/mcp4725.h b/include/linux/iio/dac/mcp4725.h
> index 91530e6..7c062e8 100644
> --- a/include/linux/iio/dac/mcp4725.h
> +++ b/include/linux/iio/dac/mcp4725.h
> @@ -10,7 +10,6 @@
>  #define IIO_DAC_MCP4725_H_
>  
>  struct mcp4725_platform_data {
> -	u16 vref_mv;
>  };

Might as well remove the whole struct and file and drop the if (!pdata)
check in the driver probe function. Having to declare a empty platform_data
for the driver to work is not that sensible.
