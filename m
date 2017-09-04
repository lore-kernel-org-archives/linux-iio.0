Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam01on0049.outbound.protection.outlook.com ([104.47.34.49]:26480
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753776AbdIDPd3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 4 Sep 2017 11:33:29 -0400
From: "Bogdan, Dragos" <Dragos.Bogdan@analog.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio:ad7793: Fix the serial interface reset
Date: Mon, 4 Sep 2017 15:33:25 +0000
Message-ID: <6067964B99C6A049AA5840B6F7BB2D0ABDAD4161@NWD2MBX5.ad.analog.com>
References: <20170904150048.12420-1-dragos.bogdan@analog.com>
 <20170904162613.00003d47@huawei.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/04/2017 06:27 PM, Jonathan Cameron wrote:=0A=
> On Mon, 4 Sep 2017 18:00:48 +0300=0A=
> Dragos Bogdan <dragos.bogdan@analog.com> wrote:=0A=
>=0A=
>> The serial interface can be reset by writing 32 consecutive 1s to the de=
vice.=0A=
>> The value of 'ret' is overwritten when ad7793_check_platform_data() is c=
alled,=0A=
>> so it should be initialized to -1 only before doing the spi_write().=0A=
>>=0A=
>> Fixes: commit 2edb769d246e ("iio:ad7793: Add support for the ad7798 and =
ad7799")=0A=
>>=0A=
>> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>=0A=
> Hi Dragos,=0A=
>=0A=
> I'd prefer we introduced a separate variable.  Using ret for this=0A=
> is what got us into trouble in the first place.=0A=
>=0A=
> Would you mind respining with that change?=0A=
>=0A=
> Thanks,=0A=
>=0A=
> Jonathan=0A=
=0A=
Hi Jonathan,=0A=
=0A=
I agree with your suggestion. I'll change it accordingly in v2.=0A=
=0A=
Thanks,=0A=
Dragos=0A=
=0A=
>> ---=0A=
>>  drivers/iio/adc/ad7793.c | 3 ++-=0A=
>>  1 file changed, 2 insertions(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c=0A=
>> index e6706a09e100..8680abf72dd2 100644=0A=
>> --- a/drivers/iio/adc/ad7793.c=0A=
>> +++ b/drivers/iio/adc/ad7793.c=0A=
>> @@ -257,7 +257,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,=
=0A=
>>  	unsigned int vref_mv)=0A=
>>  {=0A=
>>  	struct ad7793_state *st =3D iio_priv(indio_dev);=0A=
>> -	int i, ret =3D -1;=0A=
>> +	int i, ret;=0A=
>>  	unsigned long long scale_uv;=0A=
>>  	u32 id;=0A=
>>  =0A=
>> @@ -266,6 +266,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,=
=0A=
>>  		return ret;=0A=
>>  =0A=
>>  	/* reset the serial interface */=0A=
>> +	ret =3D -1;=0A=
>>  	ret =3D spi_write(st->sd.spi, (u8 *)&ret, sizeof(ret));=0A=
>>  	if (ret < 0)=0A=
>>  		goto out;=0A=
>=0A=
>=0A=
