Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45081 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbaLZMQd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Dec 2014 07:16:33 -0500
Message-ID: <549D519F.1020300@kernel.org>
Date: Fri, 26 Dec 2014 12:16:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael.Hennerich@analog.com, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: trigger: Add a blank line after declarations
References: <1418721366-5566-1-git-send-email-roberta.dobrescu@gmail.com> <CAEnQRZBcrBgBCL_hT11=vdgODN0qWrjp=XdR=OzPoyQpYrX4bA@mail.gmail.com>
In-Reply-To: <CAEnQRZBcrBgBCL_hT11=vdgODN0qWrjp=XdR=OzPoyQpYrX4bA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/12/14 11:25, Daniel Baluta wrote:
> On Tue, Dec 16, 2014 at 11:16 AM, Roberta Dobrescu
> <roberta.dobrescu@gmail.com> wrote:
>> This patch fixes the following checkpatch.pl warning:
>> WARNING: Missing a blank line after declarations
>>
>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git - initially pushed out
as testing for the autobuilders to play with it.

Jonathan
> 
>> ---
>>  drivers/iio/trigger/iio-trig-sysfs.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
>> index 254c7e9..3dfab2b 100644
>> --- a/drivers/iio/trigger/iio-trig-sysfs.c
>> +++ b/drivers/iio/trigger/iio-trig-sysfs.c
>> @@ -135,6 +135,7 @@ static int iio_sysfs_trigger_probe(int id)
>>         struct iio_sysfs_trig *t;
>>         int ret;
>>         bool foundit = false;
>> +
>>         mutex_lock(&iio_sysfs_trig_list_mut);
>>         list_for_each_entry(t, &iio_sysfs_trig_list, l)
>>                 if (id == t->id) {
>> @@ -185,6 +186,7 @@ static int iio_sysfs_trigger_remove(int id)
>>  {
>>         bool foundit = false;
>>         struct iio_sysfs_trig *t;
>> +
>>         mutex_lock(&iio_sysfs_trig_list_mut);
>>         list_for_each_entry(t, &iio_sysfs_trig_list, l)
>>                 if (id == t->id) {
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

