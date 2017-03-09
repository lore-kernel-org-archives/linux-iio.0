Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:47094 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932345AbdCISr2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Mar 2017 13:47:28 -0500
Subject: Re: PROBLEM: iio: dummy: Oops after mkdir
To: Miguel Robles <miguel.robles@farole.net>,
        Alison Schofield <amsfield22@gmail.com>
References: <20170309143421.GA4623@miguel-Z170X-UD5-TH>
 <CAEnQRZAO0X9hW=kykM5wZrweO6Xukts-XUWWyQNJM0D3fJXh4Q@mail.gmail.com>
 <592203dd4ed4ded678778294008728bc@farole.net>
 <20170309173653.GA3675@d830.WORKGROUP> <20170309174049.GB3675@d830.WORKGROUP>
 <20170309180859.GA15190@miguel-Z170X-UD5-TH>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, linux-iio@vger.kernel.org,
        linux-iio-owner@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <eb9e7974-a20f-cbda-8a00-af6a05389ea5@metafoo.de>
Date: Thu, 9 Mar 2017 19:15:54 +0100
MIME-Version: 1.0
In-Reply-To: <20170309180859.GA15190@miguel-Z170X-UD5-TH>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/09/2017 07:08 PM, Miguel Robles wrote:
> On Thu, Mar 09, 2017 at 09:40:49AM -0800, Alison Schofield wrote:
>> On Thu, Mar 09, 2017 at 09:36:54AM -0800, Alison Schofield wrote:
>>> On Thu, Mar 09, 2017 at 04:59:39PM +0100, miguel.robles@farole.net wrote:
>>>> On 2017-03-09 16:41, Daniel Baluta wrote:
>>>>> On Thu, Mar 9, 2017 at 4:34 PM, Miguel Robles <miguel.robles@farole.net>
>>>>> wrote:
>>>>>> Hello all,
[...]
>>>>>> CONFIG_IIO_CONFIGFS=m
>>>>>
>>>>> Do you also have CONFIG_IIO_SW_DEVICE right?
>>>>
>>>> Yes, and the value is:  CONFIG_IIO_SW_DEVICE=m.
>>>>
>>>> Thank you,
>>>> Miguel
>>>>>
>>>>> Will try to have a look at this asap.
>>>>>
>>>>>
>>>>> thanks,
>>>>> Daniel.
>>>
>>> Daniel,
>>> You probably saw, but just in case...
>>> I verified that the process, including the above mkdir, is working on
>>> 4.10-rc3.  (So, I'm relieved the Outreachy applicants won't start
>>> hitting it.)
>>> alisons
>>
>> I see Lars' patch! 
>> It worked for me because I used CONFIG_IIO_CONFIGFS built-in.
>> alisons
>>
> I applied Lar's patch and now the command is working fine!
> Even if I do not understand very well the patch. I mean, I always declared
> CONFIG_IIO_CONFIGFS, so the code should be normally always compiled.

What the kernel build system does is when the symbol is select as built-in
(=y) it does `#define CONFIG_CONFIGFS_FS`. When the symbol is selected as a
module (=m) it does `#define CONFIG_CONFIGFS_FS_MODULE`. The IS_ENABLED()
macro basically checks for both and evaluates to true if either of them is
defined.

