Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41003 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbeCHT1g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Mar 2018 14:27:36 -0500
Date: Fri, 09 Mar 2018 00:57:31 +0530
In-Reply-To: <20180308191111.GA2041@himanshu-Vostro-3559>
References: <1520532977-10653-1-git-send-email-shreeya.patel23498@gmail.com> <20180308191111.GA2041@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v4] Staging: iio: adis16209: Change some macro names
To: Himanshu Jha <himanshujha199640@gmail.com>
CC: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
From: Shreeya Patel <shreeya.patel23498@gmail.com>
Message-ID: <6EF6C73A-ED18-4C5F-8368-929258026979@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 9 March 2018 00:41:12 GMT+05:30, Himanshu Jha <himanshujha199640@gmail=
=2Ecom> wrote:
>On Thu, Mar 08, 2018 at 11:46:17PM +0530, Shreeya Patel wrote:
>> Make some of the macro names according to the names
>> given in the datasheet of the adis16209 driver and
>> have slight indentation in field definitions to make
>> them clearly different from the register addresses=2E
>>=20
>> Signed-off-by: Shreeya Patel <shreeya=2Epatel23498@gmail=2Ecom>
>> ---
>>=20
>> Changes in v4
>>   -Have slight indentation in field definitions=2E
>>=20
>>  drivers/staging/iio/accel/adis16209=2Ec | 48
>+++++++++++++++++------------------
>>  1 file changed, 24 insertions(+), 24 deletions(-)
>>=20
>> diff --git a/drivers/staging/iio/accel/adis16209=2Ec
>b/drivers/staging/iio/accel/adis16209=2Ec
>> index eb5c878=2E=2E19636e2 100644
>> --- a/drivers/staging/iio/accel/adis16209=2Ec
>> +++ b/drivers/staging/iio/accel/adis16209=2Ec
>> @@ -68,21 +68,21 @@
>>  #define  ADIS16209_MSC_CTRL_ACTIVE_HIGH		BIT(1)
>>  #define  ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
>> =20
>> -#define ADIS16209_STAT_REG			0x3C
>> -#define  ADIS16209_STAT_ALARM2			BIT(9)
>> -#define  ADIS16209_STAT_ALARM1			BIT(8)
>> -#define ADIS16209_STAT_SELFTEST_FAIL_BIT	5
>> -#define ADIS16209_STAT_SPI_FAIL_BIT		3
>> -#define ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
>> +#define ADIS16209_DIAG_STAT_REG			0x3C
>> +#define  ADIS16209_DIAG_STAT_ALARM2		BIT(9)
>> +#define  ADIS16209_DIAG_STAT_ALARM1		BIT(8)
>> +#define  ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT	5
>> +#define  ADIS16209_DIAG_STAT_SPI_FAIL_BIT	3
>> +#define  ADIS16209_DIAG_STAT_FLASH_UPT_BIT	2
>
>#define ADIS16209_STAT_FLASH_UPT_FAIL_BIT    2
>?
>It represents flash update fail bit!=20

I think so that I have sent the wrong patch :(

This is totally the reverse of the change that I wanted to have=2E=20
Maybe I messed up with this patch=2E=20

Jonathan, please avoid this patch=2E=20
I'll send the corrected one soon=2E=20

Thanks=20

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
