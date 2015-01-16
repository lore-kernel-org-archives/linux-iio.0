Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33204 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbbAQNvd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 17 Jan 2015 08:51:33 -0500
Message-ID: <54B99626.5030208@kernel.org>
Date: Fri, 16 Jan 2015 22:52:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael.Hennerich@analog.com, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: light: cm32181: Fix typo 's/claibscale/calibscale/'
References: <1421360681-1443-1-git-send-email-roberta.dobrescu@gmail.com> <CAEnQRZBp7BC-phZ71h3EmkTM9KeY5_3GMJszbiYdWEAk+Nbaiw@mail.gmail.com>
In-Reply-To: <CAEnQRZBp7BC-phZ71h3EmkTM9KeY5_3GMJszbiYdWEAk+Nbaiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/01/15 09:40, Daniel Baluta wrote:
> On Fri, Jan 16, 2015 at 12:24 AM, Roberta Dobrescu
> <roberta.dobrescu@gmail.com> wrote:
>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to a temporary branch that will get rebased and become
togreg sometime soon (when internet / time available)

In the meantime, possibly / probably pushed out as testing for the autobuilders
to play with it.

Jonathan
> 
>> ---
>>  drivers/iio/light/cm32181.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
>> index ad36b29..5d12ae54 100644
>> --- a/drivers/iio/light/cm32181.c
>> +++ b/drivers/iio/light/cm32181.c
>> @@ -169,7 +169,7 @@ static int cm32181_write_als_it(struct cm32181_chip *cm32181, int val)
>>   * @cm32181:   pointer of struct cm32181.
>>   *
>>   * Convert sensor raw data to lux.  It depends on integration
>> - * time and claibscale variable.
>> + * time and calibscale variable.
>>   *
>>   * Return: Positive value is lux, otherwise is error code.
>>   */
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

