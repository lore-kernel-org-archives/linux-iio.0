Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:59949 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbaHCJc3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Aug 2014 05:32:29 -0400
Received: by mail-la0-f45.google.com with SMTP id ty20so4471007lab.32
        for <linux-iio@vger.kernel.org>; Sun, 03 Aug 2014 02:32:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53DDEEC6.2070300@metafoo.de>
References: <CADYu309fV8qNv0v03xr1T0eeLEV97YFPoAVkKdT8jZcom8uqGQ@mail.gmail.com>
	<53DCCB4A.3020304@kernel.org>
	<CADYu30-9Y4rjf5kZZea32pL04BGe1y1E0wCNtcy4qAn1wO1gHQ@mail.gmail.com>
	<53DD1881.1020607@kernel.org>
	<53DDEEC6.2070300@metafoo.de>
Date: Sun, 3 Aug 2014 15:02:27 +0530
Message-ID: <CADYu30--CpVmTowroGJEcKbg78B-xrzGXfdhFxpOYXAgcD41gA@mail.gmail.com>
Subject: Re: IIO: Why cannot open two iio device node file descriptors
 simultaneously ?
From: Aniroop Mathur <aniroop.mathur@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Aug 3, 2014 at 1:41 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 08/02/2014 06:57 PM, Jonathan Cameron wrote:
> [...]
>
>>> So, even after opening iio device node,
>>> can we write the data to IIO device node from user space ?
>>> (I do not see write function in below fileops)
>>
>>
>> Indeed.  Lars was working on some buffered support for DACs but hasn't
>> yet submitted it for mainline inclusion.  Lars how is the buffered output
>> stuff coming along?
>
>
> I still need to do the re-write you wanted me to do, otherwise its working
> fine ;)
>

Great :)
So, it is possible to write data to iio fd ?

char *data;
int nbytes = 24;
int res = write(iio_fd, data, nbytes);

This will work fine ?

If yes, can you please help to tell where is write function defined ?
I could find only read function here
static const struct file_operations iio_event_chrdev_fileops = {
     .read =  iio_event_chrdev_read,
     .poll =  iio_event_poll,
     .release = iio_event_chrdev_release,
     .owner = THIS_MODULE,
     .llseek = noop_llseek,
}

> - Lars
>

Thanks,
Aniroop
