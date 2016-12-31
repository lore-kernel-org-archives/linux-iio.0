Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33873 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754655AbcLaMzz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 31 Dec 2016 07:55:55 -0500
Received: by mail-pg0-f66.google.com with SMTP id b1so25041437pgc.1
        for <linux-iio@vger.kernel.org>; Sat, 31 Dec 2016 04:55:54 -0800 (PST)
Message-ID: <1483188948.1938.1.camel@researchut.com>
Subject: Re: sensor-hub: Move the memset to sensor_hub_get_feature()
From: Ritesh Raj Sarraf <rrs@researchut.com>
Reply-To: rrs@researchut.com
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>
Date: Sat, 31 Dec 2016 18:25:48 +0530
In-Reply-To: <1483116610.27585.51.camel@linux.intel.com>
References: <1482925101.8484.1.camel@researchut.com>
         <1482931381.8484.3.camel@researchut.com>
         <1482943685.4497.19.camel@linux.intel.com>
         <1482945855.8484.8.camel@researchut.com>
         <1482946633.12558.1.camel@researchut.com>
         <1482947598.21657.1.camel@researchut.com>
         <1483032127.27585.13.camel@linux.intel.com>
         <1483032694.3173.3.camel@researchut.com>
         <1483094837.11693.3.camel@researchut.com>
         <1483116610.27585.51.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, 2016-12-30 at 08:50 -0800, Srinivas Pandruvada wrote:
> > Do you think power savings mode can impact these devices ? I know of
> > USB plugged
> > keyboard/mice to generally break, when enabling power savings mode.
> > But I had
> > hoped that in-built USB devices were immune to it.
> > 
> 
> This is possible. If your remove from blacklist does it still work? May
> be rebuild of kernel fixed this:-)

As much as I want to blame it on power savings, that is not the case. Even with
power savings enabled, it is all working fine now.

Which means the new kernel build fixed things. Which made me wonder what the
difference could be, because I built this new kernel on the same Debian machine,
with the same toolchain. And not only did it fix this issue, it has fixed an old
annoying USB issue [1] and also many other glitches [2].

While it is nice, if I wanted to pin point any difference, all that I could see
is the tool used to build the kernel packages. Earlier, it was through make-kpkg 
whereas now I am building it with the stock binpkg-deb target.

Other than that, I am out of ideas on why things have improved.
Whatever be the case, I'm glad that I don't see those annoying issues anymore.
What a way to end the year. Happy New Year, 2017 to all of you.

[1] https://www.spinics.net/lists/linux-usb/msg144634.html
[2] https://www.researchut.com/blog/lenovo-yoga-2-13-debian

- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAlhnqtQACgkQpjpYo/Lh
dWk7fRAAtXpXy1DQBvi0x3dCD7QF60kXFBBAShWtMF6Q8aOkmaobjzQsUpDaMAsk
vzvEYW951T91NzicSKog+2XW3F08JqpSuggnXrc4+uaegm+TD8qydIkX4ogkCi7m
zzTf2UDsV8qacZkqsWfLY01BibLTdo1bwXMxMjym+ufpayk3HJyNXu7Y1hx4vATk
Rq8mHVDtD6szdo2fT1My3mfRgQuWlYqvPOylUzSq3+5N1eUyASPAB/bXBEm4Iapp
+E+lEqmEraB/MN9wuW6uhWUJfy+oQwwDiGe77V+7pV6eDA0c1NE9BemlL/xEmUZ6
Ma4rRbWDnDPKkW7vv7+kO+hIDZAbHzRWlsvgT/+LNBjKaQnBk81Y4tsZmkkzH7US
5znhpLhL99E1bylubUNRdAvSmGMIINFJjKTNyRQainyhVWJkQ0z7V7fFRsLplHgh
mxqlLlulDqPOp7KnT9YyPIMVj57T9KhMFBMaylvYWvbucF2ANsLdL6GydDEBizkz
TRc3EuOxvL1xALcq33g2m6BfdRPnjqF6sWdLLW52wxnK/3dH7wIetm87ivz2a9jA
QiS4xaVl/etXLoH1lTd9OSeUC+3hLcpjhDJ8g+SiNpIXJ0c/zBOorRDQPZrK7oZ7
2aja7Zs+YZVyx5AuPcm1LsunpNJRs1OzLsXGw2I/9AsnrGrvLFg=
=k21y
-----END PGP SIGNATURE-----

