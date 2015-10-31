Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33497 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbbJaV1Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Oct 2015 17:27:25 -0400
Received: by ykft191 with SMTP id t191so107281464ykf.0
        for <linux-iio@vger.kernel.org>; Sat, 31 Oct 2015 14:27:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5634943D.3080806@kernel.org>
References: <1446210662-10370-1-git-send-email-ciorneiioana@gmail.com>
	<5634943D.3080806@kernel.org>
Date: Sat, 31 Oct 2015 23:27:25 +0200
Message-ID: <CAHWJYFmmq5dY9+RWNg1nyV9wZzvv2MuFj0qmdmQQRnmuT0WfAQ@mail.gmail.com>
Subject: Re: [PATCH] tools: iio: avoid returning error when channel does not
 have an offset
From: Ioana Ciornei <ciorneiioana@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Matt Ranostaj <mranostay@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Oct 31, 2015 at 12:13 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 30/10/15 13:11, Ioana Ciornei wrote:
>> This patch avoids getting an error and aborting when a channel does not have a
>> specific parameter like 'offset' and the file associated with it is not present.
>> When none of the files from the device folder does not matches the desired channel's
>> param function iioutils_get_param_float should return 0.
>>
>> This change is safe previous to calling the function the parameters are set to
>> their defaults, 0 in case of 'offset'
>>
>> Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
> This is rather fixing it in the wrong place.  This function is specifically getting
> the parameter. If it is not there, then the function should return that fact.
> It's the caller that should know whether the parameter is optional.
>
> For example, build_channel_array explicitly catches the -ENOENT error and allows
> for that case.
>
> Perhaps we need to improve the documentation to make it clear that this is
> the expected behaviour?

Ok, sure. I will deal with the documentation in a patch.

Sorry for the late response.

Ioana

>
>> ---
>> not tested
>>
>>  tools/iio/iio_utils.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
>> index 5eb6793..cbaf696 100644
>> --- a/tools/iio/iio_utils.c
>> +++ b/tools/iio/iio_utils.c
>> @@ -241,7 +241,7 @@ int iioutils_get_param_float(float *output, const char *param_name,
>>               goto error_free_builtname_generic;
>>       }
>>
>> -     ret = -ENOENT;
>> +     ret = 0;
>>       while (ent = readdir(dp), ent)
>>               if ((strcmp(builtname, ent->d_name) == 0) ||
>>                   (strcmp(builtname_generic, ent->d_name) == 0)) {
>>
>
