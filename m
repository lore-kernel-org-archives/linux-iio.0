Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36306 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754533AbaHGKNO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Aug 2014 06:13:14 -0400
Message-ID: <53E35138.2040601@kernel.org>
Date: Thu, 07 Aug 2014 11:13:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: balbi@ti.com, Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [RFC/PATCH] iio: light: add support for TI's opt3001 ligth sensor
References: <1407341409-30284-1-git-send-email-balbi@ti.com> <alpine.DEB.2.01.1408061815140.29646@pmeerw.net> <20140806214222.GB3556@saruman.home> <alpine.DEB.2.01.1408062347350.7595@pmeerw.net> <20140806221823.GE3556@saruman.home> <alpine.DEB.2.01.1408070021420.7595@pmeerw.net> <20140806223045.GF3556@saruman.home> <alpine.DEB.2.01.1408070032040.7595@pmeerw.net> <20140806223842.GG3556@saruman.home>
In-Reply-To: <20140806223842.GG3556@saruman.home>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 06/08/14 23:38, Felipe Balbi wrote:
> On Thu, Aug 07, 2014 at 12:35:11AM +0200, Peter Meerwald wrote:
>> 
>>>>> ok... but then that brings up a doubt. What would I use triggered buffer for ? I already setup High/Low
>>>>> limits (thresholds) through .write_event_value(). Isn't that, pretty much, a triggered buffer ?
>>>> 
>>>> a triggered buffer reads data from the device and stores it into a buffer whenever the trigger goes off (you
>>>> are interested to capture all samples)
>>> 
>>> Alright, so something like a contious capture starting after a GPIO goes off, or something ?
>> 
>> right, one capture whenever the GPIO becomes active typically
Or if I am conjecturing correctly on what the hystersis mode here does, it
would be applicable for that.  The interrupts indicating a change would provide
the iio_trigger and that would result in the buffer being filled.

This allows you to poll/select on the data arriving.
The BMC100 driver currently under review does something very similar with
a motion detector interrupt so that data is only captured if significant
motion is going on.

>> 
>>>> events are created on certain conditions (you are not interested in all samples)
>>> 
>>> And this would be more like e.g. "tell me once I have 100 lux or more" ?
>> 
>> yes
> 
> cool thanks. I'll wait for some more review comments before sending a new version. Latest is kept at [1]
> 
> [1] https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/log/?h=opt3001
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJT41E4AAoJEFSFNJnE9BaIqogQAJdlZ3uq6Nf6BDYazpn8YfPZ
E4t7FocO6DtZHYgUp+MLOadB4cQv5VKT+K/D3RSsc3C10JhC7la3b3Rxh0+ia1wq
iu8HPTNccYkkcexamw+JSPR5TjirC4uVnajFzmtaiZ7vGD/cexP9phBHrGZsts1b
VcK44VVxi59smFi+P+6LPYqm9cc5NwjUjCErfEf73x+NzOOA6myNwoBLrH6uGRHj
kIVp4icBA3ajN5FntBEbVCKHyqeLvFUQKCznKLb+wIn7nf5yjGiHCMntlAYF9O5+
m5seoOdp0znUMkp1hAhfceyVQvyPKEV1nNZYXnH7fnYrshtcy1P/hZuhen+wIooM
+WWVUQBRVRH6Jan1lwPhz8TkXvwFwPGd1+5BTq/wk4J0s6YEUpn+Vee1Q7m2e4u1
Rm4JSA2Kx/WppBuF9kTG+tjBBm9D0MVhN0qoNT/Q4qXTop24pY4Vxmf8ZyvkB8CH
fSrj+p/wkinNJksKjuu8VfCr3WH/Fni+I8comLfIo1AHl63ADR+3z1U/tMndTMdS
TBoAgYOnhWQHVoL1IL5qbDv//wBGqJdwZL9DoctYnwNaY2mtbmUdsciY1T4htmJe
M/1PGl1h5yjCMxiT54jp35XfWgtUav2MvVkdKguh6KlDt0RqSjvP4ZKkyOHJxvsG
3QlQTvxr+tupJzfYH+4v
=cUWM
-----END PGP SIGNATURE-----
