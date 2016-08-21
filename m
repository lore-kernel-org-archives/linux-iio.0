Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51117 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbcHUKxl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 06:53:41 -0400
Subject: Re: [PATCH] iio: iio-utils: use channel modifier scaling if it exists
To: Matt Ranostay <mranostay@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <1469941905-2600-1-git-send-email-mranostay@gmail.com>
 <CAKzfze8szHzw-QoY_h98VMgYy-oMnPEZNkB9hP=zbYzRLTnk4w@mail.gmail.com>
Cc: Marek Vasut <marex@denx.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5e217aab-cab9-969f-2c5b-b0de95a96805@kernel.org>
Date: Sun, 21 Aug 2016 11:53:27 +0100
MIME-Version: 1.0
In-Reply-To: <CAKzfze8szHzw-QoY_h98VMgYy-oMnPEZNkB9hP=zbYzRLTnk4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/08/16 05:01, Matt Ranostay wrote:
> On Sat, Jul 30, 2016 at 10:11 PM, Matt Ranostay <mranostay@gmail.com> wrote:
>> Now there are channel modifiers with their own scaling those should be
>> used when possible over the generic channel type scaling.
>>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> 
> Jonathan,
> 
> Know you are probably still digging out your inbox since your holiday.
> Any comments on this one?
> 
Indeed - still not caught up.  Was hoping for space on the plane,
but of course despite it being the middle of the day the person
in front of me immediately put their chair fully back. Laptop too
big to fit at that point!

Jonathan
> Thanks,
> 
> Matt
> 
>> ---
>>  tools/iio/iio_utils.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
>> index 5eb6793f3972..7a6d61c6c012 100644
>> --- a/tools/iio/iio_utils.c
>> +++ b/tools/iio/iio_utils.c
>> @@ -121,10 +121,6 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
>>
>>         ret = -ENOENT;
>>         while (ent = readdir(dp), ent)
>> -               /*
>> -                * Do we allow devices to override a generic name with
>> -                * a specific one?
>> -                */
>>                 if ((strcmp(builtname, ent->d_name) == 0) ||
>>                     (strcmp(builtname_generic, ent->d_name) == 0)) {
>>                         ret = asprintf(&filename,
>> @@ -178,6 +174,13 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
>>                         sysfsfp = 0;
>>                         free(filename);
>>                         filename = 0;
>> +
>> +                       /*
>> +                        * Avoid having a more generic entry overwriting
>> +                        * the settings.
>> +                        */
>> +                       if (strcmp(builtname, ent->d_name) == 0)
>> +                               break;
>>                 }
>>
>>  error_close_sysfsfp:
>> --
>> 2.7.4
>>

