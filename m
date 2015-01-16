Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33197 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbbAQNvd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 17 Jan 2015 08:51:33 -0500
Message-ID: <54B994C3.8000509@kernel.org>
Date: Fri, 16 Jan 2015 22:46:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael.Hennerich@analog.com, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: light: hid-sensor-als: Use IIO_CHAN_INFO_RAW instead
 of hardcoded 0
References: <1421360720-1533-1-git-send-email-roberta.dobrescu@gmail.com> <CAEnQRZALuzB2rudR8QeOFeA4Bk5c4SgqgCHGGonfprOrpfMfFA@mail.gmail.com>
In-Reply-To: <CAEnQRZALuzB2rudR8QeOFeA4Bk5c4SgqgCHGGonfprOrpfMfFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/01/15 09:36, Daniel Baluta wrote:
> On Fri, Jan 16, 2015 at 12:25 AM, Roberta Dobrescu
> <roberta.dobrescu@gmail.com> wrote:
>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git - initially to be pushed out
as testing when I remember and am not on a train with no (free) internet.

Mind you this email will probably send at the same time :)

J
> 
>> ---
>>  drivers/iio/light/hid-sensor-als.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
>> index a5283d7..e97101d 100644
>> --- a/drivers/iio/light/hid-sensor-als.c
>> +++ b/drivers/iio/light/hid-sensor-als.c
>> @@ -85,7 +85,7 @@ static int als_read_raw(struct iio_dev *indio_dev,
>>         *val = 0;
>>         *val2 = 0;
>>         switch (mask) {
>> -       case 0:
>> +       case IIO_CHAN_INFO_RAW:
>>                 switch (chan->scan_index) {
>>                 case  CHANNEL_SCAN_INDEX_ILLUM:
>>                         report_id = als_state->als_illum.report_id;
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

