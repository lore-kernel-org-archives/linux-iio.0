Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-223.synserver.de ([212.40.185.223]:1163 "EHLO
	smtp-out-223.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161025Ab2KWJyb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 23 Nov 2012 04:54:31 -0500
Message-ID: <50AF47D1.3080900@metafoo.de>
Date: Fri, 23 Nov 2012 10:54:25 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Guido Del Vescovo <guido.delvescovo@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Patil, Rachna" <rachna@ti.com>
Subject: Re: Beaglebone built-in ADC with IIO
References: <CAE1ao5EKXn_aR_1PE_OyAeFYhYm86AAjAyaRH0yNb8c4fLr0fQ@mail.gmail.com>
In-Reply-To: <CAE1ao5EKXn_aR_1PE_OyAeFYhYm86AAjAyaRH0yNb8c4fLr0fQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

I added the IIO mailing list and Patil, Rachna, who is the author of the
driver, to Cc.

On 11/23/2012 09:42 AM, Guido Del Vescovo wrote:
> Hi Lars. I'm trying to read the analog inputs of the beaglebone board at an
> higher rate than the one which can be achieved through the *sysfs* method
> (open the file with *fopen*, read a single value with *fscanf*, close the
> file, repeat. C language, of course). In the #beagle IRC channel at
> freenode, I was told to look at the IIO project. I was also told that the
> latest kernel 3.7 for the beaglebone (angstrom distribution) was equipped
> with IIO support for the built-in ADC, but that it is not tested yet. Well,
> I would like to test it. The problem is, I have no idea about how to write
> an hello world application reading data from the analog inputs. I guess I
> should bypass the sysfs and talk directly to the IIO layer, but I'm having
> hard times finding the proper documentation and examples, maybe I'm not
> looking in the right direction.

So yes, there is support for the AM335x ADC in IIO, but not for 3.7. It will
be in 3.8. While IIO provides a character device interface which allows you
to read multiple samples at once, the driver does not implement it yet. So
as it is right now even with IIO you are stuck with reading sysfs files by hand.

- Lars
