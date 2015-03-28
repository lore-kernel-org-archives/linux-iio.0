Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59419 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbbC1LDD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2015 07:03:03 -0400
Message-ID: <55168A65.6020200@kernel.org>
Date: Sat, 28 Mar 2015 11:03:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Irina Tirdea <irina.tirdea@intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools: iio: generic_buffer: Fix generic scale extraction
References: <1427457180-2668-1-git-send-email-irina.tirdea@intel.com> <CAEnQRZBFjx9y6QgNOFFdeyNF5960X+yNLSi6kkMCTNLOb2kiRw@mail.gmail.com>
In-Reply-To: <CAEnQRZBFjx9y6QgNOFFdeyNF5960X+yNLSi6kkMCTNLOb2kiRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/03/15 12:57, Daniel Baluta wrote:
> On Fri, Mar 27, 2015 at 1:53 PM, Irina Tirdea <irina.tirdea@intel.com> wrote:
>> When using generic_buffer to read data, the scale is not properly
>> detected for scale shared by type. This is caused by a problem
>> with the generation of generic name out of the full name.
>> E.g.: for current->name in_accel_z, the extracted generic name
>> is "in" (when it should be "in_accel"). This is used in generic_buffer
>> to generate scale and offset paths (in_accel_scale).
>>
>> Consider the in_ or out_ prefix when extracting the generic name
>> from the full name.
>>
>> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> 
> Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git.  Might be worth backporting
once it is in mainline.

J
> 
>> ---
>>  tools/iio/iio_utils.c | 20 +++++++++++++++++---
>>  1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
>> index aea9282..63fbf99 100644
>> --- a/tools/iio/iio_utils.c
>> +++ b/tools/iio/iio_utils.c
>> @@ -18,6 +18,11 @@
>>
>>  const char *iio_dir = "/sys/bus/iio/devices/";
>>
>> +static char * const iio_direction[] = {
>> +       "in",
>> +       "out",
>> +};
>> +
>>  /**
>>   * iioutils_break_up_name() - extract generic name from full channel name
>>   * @full_name: the full channel name
>> @@ -28,10 +33,19 @@ int iioutils_break_up_name(const char *full_name,
>>  {
>>         char *current;
>>         char *w, *r;
>> -       char *working;
>> +       char *working, *prefix = "";
>> +       int i;
>>
>> -       current = strdup(full_name);
>> +       for (i = 0; i < sizeof(iio_direction) / sizeof(iio_direction[0]); i++)
>> +               if (!strncmp(full_name, iio_direction[i],
>> +                            strlen(iio_direction[i]))) {
>> +                       prefix = iio_direction[i];
>> +                       break;
>> +               }
>> +
>> +       current = strdup(full_name + strlen(prefix) + 1);
>>         working = strtok(current, "_\0");
>> +
>>         w = working;
>>         r = working;
>>
>> @@ -43,7 +57,7 @@ int iioutils_break_up_name(const char *full_name,
>>                 r++;
>>         }
>>         *w = '\0';
>> -       *generic_name = strdup(working);
>> +       asprintf(generic_name, "%s_%s", prefix, working);
>>         free(current);
>>
>>         return 0;
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

