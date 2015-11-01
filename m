Return-Path: <ciorneiioana@gmail.com>
MIME-Version: 1.0
In-Reply-To: <56365999.5010003@kernel.org>
References: <1446210662-10370-1-git-send-email-ciorneiioana@gmail.com>
	<5634943D.3080806@kernel.org>
	<CAHWJYFmmq5dY9+RWNg1nyV9wZzvv2MuFj0qmdmQQRnmuT0WfAQ@mail.gmail.com>
	<CAHWJYF=kLaJfRKPNDzcHkEWn9ThmzRQ8J_p7Ft04w+rDpQ5CHw@mail.gmail.com>
	<56365999.5010003@kernel.org>
Date: Sun, 1 Nov 2015 21:53:29 +0200
Message-ID: <CAHWJYFnO3eTVBxP-wq+qs-hqeghUu5L-UVNp0KLiEdAa4QSTmQ@mail.gmail.com>
Subject: Re: [PATCH] tools: iio: avoid returning error when channel does not
 have an offset
From: Ioana Ciornei <ciorneiioana@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Matt Ranostaj <mranostay@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sun, Nov 1, 2015 at 8:27 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 01/11/15 11:30, Ioana Ciornei wrote:
>> On Sat, Oct 31, 2015 at 11:27 PM, Ioana Ciornei <ciorneiioana@gmail.com> wrote:
>>> On Sat, Oct 31, 2015 at 12:13 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>>>> On 30/10/15 13:11, Ioana Ciornei wrote:
>>>>> This patch avoids getting an error and aborting when a channel does not have a
>>>>> specific parameter like 'offset' and the file associated with it is not present.
>>>>> When none of the files from the device folder does not matches the desired channel's
>>>>> param function iioutils_get_param_float should return 0.
>>>>>
>>>>> This change is safe previous to calling the function the parameters are set to
>>>>> their defaults, 0 in case of 'offset'
>>>>>
>>>>> Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
>>>> This is rather fixing it in the wrong place.  This function is specifically getting
>>>> the parameter. If it is not there, then the function should return that fact.
>>>> It's the caller that should know whether the parameter is optional.
>>>>
>>>> For example, build_channel_array explicitly catches the -ENOENT error and allows
>>>> for that case.
>>>>
>>
>> I took a look at the build_channel_array and the
>> iioutils_get_param_float and now I do not understand how the generic
>> buffer tool fails at line 495 (where the check is made) if there is no
>> offset in the channel.
>> If there is no file in the device folder that matches *_offset it the
>> iioutils_get_param_float call should return -ENOENT and it should pass
>> that line since the check permits it.
>>
>> Sorry, but now I'm confused..
> Me too!  Anyhow, we are clearly both missing something here.
>
> Could you add a few debugging printf lines and chase it through to find
> out if for some reason, in this case, the code is not returning -ENOENT
> from that call?  I wonder if there is some other error occurring
> during that functional call.
>
> It's incredibly common to not have an offset so this really ought to be
> tested code paths.  I can obviously rig something up to test,  but given
> you already have a setup that is triggering the issue makes sense for
> you to pursue it if you have time.

I will definitely pursue this as soon as possible.

Thanks for the feedback.

Ioana



>
> Jonathan
>
>>
>> Ioana
>>
>>>> Perhaps we need to improve the documentation to make it clear that this is
>>>> the expected behaviour?
>>>
>>> Ok, sure. I will deal with the documentation in a patch.
>>>
>>> Sorry for the late response.
>>>
>>> Ioana
>>>
>>>>
>>>>> ---
>>>>> not tested
>>>>>
>>>>>  tools/iio/iio_utils.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
>>>>> index 5eb6793..cbaf696 100644
>>>>> --- a/tools/iio/iio_utils.c
>>>>> +++ b/tools/iio/iio_utils.c
>>>>> @@ -241,7 +241,7 @@ int iioutils_get_param_float(float *output, const char *param_name,
>>>>>               goto error_free_builtname_generic;
>>>>>       }
>>>>>
>>>>> -     ret = -ENOENT;
>>>>> +     ret = 0;
>>>>>       while (ent = readdir(dp), ent)
>>>>>               if ((strcmp(builtname, ent->d_name) == 0) ||
>>>>>                   (strcmp(builtname_generic, ent->d_name) == 0)) {
>>>>>
>>>>
>
