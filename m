Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpauth-dc2.online.net ([62.210.16.40]:54207 "EHLO
        smtpauth-dc2-1.online.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753918AbdCIP7n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Mar 2017 10:59:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Thu, 09 Mar 2017 16:59:39 +0100
From: miguel.robles@farole.net
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-iio-owner@vger.kernel.org
Subject: Re: PROBLEM: iio: dummy: Oops after mkdir
In-Reply-To: <CAEnQRZAO0X9hW=kykM5wZrweO6Xukts-XUWWyQNJM0D3fJXh4Q@mail.gmail.com>
References: <20170309143421.GA4623@miguel-Z170X-UD5-TH>
 <CAEnQRZAO0X9hW=kykM5wZrweO6Xukts-XUWWyQNJM0D3fJXh4Q@mail.gmail.com>
Message-ID: <592203dd4ed4ded678778294008728bc@farole.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-03-09 16:41, Daniel Baluta wrote:
> On Thu, Mar 9, 2017 at 4:34 PM, Miguel Robles 
> <miguel.robles@farole.net> wrote:
>> Hello all,
>> 
>> I am beginning with Linux Kernel development. So I am trying to make
>> the IIO tasks posted on kernelnewbies DOT org.
>> But I got stuck with this problem that I am describing you hereafter
>> hoping that someone could bring me any feedback.
>> 
>> Many thanks,
>> Miguel ROBLES
>> 
>> ----------
>> DESCRIPTION
>> -----------
>> 
>> After loading the corresponding IIO modules and mountig the configfs 
>> filesystem
>> I can not create an instance device with mkdir using the command:
>> 
>> $ sudo mkdir /config/iio/devices/dummy/my_dummy_device
>> Killed
>> 
>> I get the "Killed" message and looking at my syslog file, I got the 
>> warning
>> "refcount_t: increment on 0; use-after-free" followed by an "Oops" 
>> message.
>> When trying to execute the command one more time, the execution never 
>> finishes.
>> 
>> 
>> ------
>> CONTEXT
>> -------
>> 
>> - Tried on 2 linux kernel releases:
>>       - kernel: 4.10 (commit: 4977ab6)
>>       - Kernel: 4.11 (commit: ec3b93a)
>> 
>> - Compiled with config file including the following options for IIO:
>> 
>> #
>> # IIO dummy driver
>> #
>> CONFIG_IIO_DUMMY_EVGEN=m
>> CONFIG_IIO_SIMPLE_DUMMY=m
>> CONFIG_IIO_SIMPLE_DUMMY_EVENTS=y
>> CONFIG_IIO_SIMPLE_DUMMY_BUFFER=y
>> 
>> CONFIG_IIO_CONFIGFS=m
> 
> Do you also have CONFIG_IIO_SW_DEVICE right?

Yes, and the value is:  CONFIG_IIO_SW_DEVICE=m.

Thank you,
Miguel
> 
> Will try to have a look at this asap.
> 
> 
> thanks,
> Daniel.
