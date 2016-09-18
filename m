Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:37903 "EHLO
        smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753764AbcIRIxf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2016 04:53:35 -0400
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
        by smtpfb1-g21.free.fr (Postfix) with ESMTP id 4D25D77D292
        for <linux-iio@vger.kernel.org>; Sun, 18 Sep 2016 10:53:28 +0200 (CEST)
Subject: Re: [PATCH] stagging:iio:ad9834: add devicetree property support
To: Lars-Peter Clausen <lars@metafoo.de>,
        Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>,
        linux-iio@vger.kernel.org
References: <20160911105229.25791-1-gwenhael.goavec-merou@trabucayre.com>
 <2bd4af3a-1ea3-3dde-92c8-7aac1d0205f1@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Paul Cercueil <paul.cercueil@analog.com>,
        devel@driverdev.osuosl.org
From: Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>
Message-ID: <1f2d6c16-67e7-2e74-3ada-c37a16ad6bd9@trabucayre.com>
Date: Sun, 18 Sep 2016 10:53:26 +0200
MIME-Version: 1.0
In-Reply-To: <2bd4af3a-1ea3-3dde-92c8-7aac1d0205f1@metafoo.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,
Thanks for the review. I will send a new patch.
Gwenhael

On 12/09/2016 14:02, Lars-Peter Clausen wrote:
> Hi,
>
> Thanks for the patch.
>
> On 09/11/2016 12:52 PM, Gwenhael Goavec-Merou wrote:
>> +static struct ad9834_platform_data *ad9834_parse_dt(struct spi_device *spi)
>> +{
>> +	struct ad9834_platform_data *pdata;
>> +	struct device_node *np = spi->dev.of_node;
>> +
>> +	pdata = devm_kzalloc(&spi->dev, sizeof(*pdata), GFP_KERNEL);
>> +	if (!pdata)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	if (of_property_read_u32(np, "mclk", &pdata->mclk))
>> +		return ERR_PTR(-ENODEV);
>
> The input clock should be using the standard clock bindings.
>
>> +	if (of_property_read_u32(np, "freq0", &pdata->freq0))
>> +		return ERR_PTR(-ENODEV);
>> +	if (of_property_read_u32(np, "freq1", &pdata->freq1))
>> +		return ERR_PTR(-ENODEV);
>> +	if (of_property_read_u16(np, "phase0", &pdata->phase0))
>> +		return ERR_PTR(-ENODEV);
>> +	if (of_property_read_u16(np, "phase1", &pdata->phase1))
>> +		return ERR_PTR(-ENODEV);
>> +	pdata->en_div2 = of_property_read_bool(np, "en_div2");
>> +	pdata->en_signbit_msb_out = of_property_read_bool(np,
>> +					"en_signbit_msb_out");
>
> The other attributes seem to be more runtime configuration data, rather than
> hardware description. Maybe just choose a fixed default.
>
> - Lars
>
