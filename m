Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35841 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111AbbFAVRL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:17:11 -0400
Message-ID: <556C809A.7000504@kernel.org>
Date: Mon, 01 Jun 2015 16:56:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Dan Carpenter <dan.carpenter@oracle.com>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch] iio: magnetometer: correct a harmless off by one check
References: <20150527082052.GA19423@mwanda> <CAEnQRZDZFSQ0E7_JUrx6CsSF6erg+USDAJyMFhhhz=Brbk-VPg@mail.gmail.com>
In-Reply-To: <CAEnQRZDZFSQ0E7_JUrx6CsSF6erg+USDAJyMFhhhz=Brbk-VPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/05/15 09:37, Daniel Baluta wrote:
> On Wed, May 27, 2015 at 11:20 AM, Dan Carpenter
> <dan.carpenter@oracle.com> wrote:
>> The line before limits i to 0-3 so the existing code works fine but the
>> check is still off by one and >= is intended instead of >.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Good catch.
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git - initially pushed out as
testing when I have a network that does anything other than https.

J
> 
>>
>> diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
>> index aa6e25d..c71392c 100644
>> --- a/drivers/iio/magnetometer/mmc35240.c
>> +++ b/drivers/iio/magnetometer/mmc35240.c
>> @@ -308,7 +308,7 @@ static int mmc35240_read_raw(struct iio_dev *indio_dev,
>>                         return ret;
>>
>>                 i = (reg & MMC35240_CTRL1_BW_MASK) >> MMC35240_CTRL1_BW_SHIFT;
>> -               if (i < 0 || i > ARRAY_SIZE(mmc35240_samp_freq))
>> +               if (i < 0 || i >= ARRAY_SIZE(mmc35240_samp_freq))
>>                         return -EINVAL;
>>
>>                 *val = mmc35240_samp_freq[i];
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

