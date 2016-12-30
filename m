Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35634 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbcL3KrX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 05:47:23 -0500
Received: by mail-pg0-f52.google.com with SMTP id i5so111682674pgh.2
        for <linux-iio@vger.kernel.org>; Fri, 30 Dec 2016 02:47:23 -0800 (PST)
Message-ID: <1483094837.11693.3.camel@researchut.com>
Subject: Re: sensor-hub: Move the memset to sensor_hub_get_feature()
From: Ritesh Raj Sarraf <rrs@researchut.com>
Reply-To: rrs@researchut.com
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>
Date: Fri, 30 Dec 2016 16:17:17 +0530
In-Reply-To: <1483032694.3173.3.camel@researchut.com>
References: <1482925101.8484.1.camel@researchut.com>
         <1482931381.8484.3.camel@researchut.com>
         <1482943685.4497.19.camel@linux.intel.com>
         <1482945855.8484.8.camel@researchut.com>
         <1482946633.12558.1.camel@researchut.com>
         <1482947598.21657.1.camel@researchut.com>
         <1483032127.27585.13.camel@linux.intel.com>
         <1483032694.3173.3.camel@researchut.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello Srini,

On Thu, 2016-12-29 at 23:01 +0530, Ritesh Raj Sarraf wrote:
> On Thu, 2016-12-29 at 09:22 -0800, Srinivas Pandruvada wrote:
> > > If you need more information, please tell me.
> > 
> > I tried on couple of systems with the patch. It seems to fix the issue.
> > It is possible some low level power related changes have impacted this.
> > Can you do bisect? I suggest just try 4.9-rc1. I think it will not work
> > there probably.
> 
> Okay. Let me do a bisect on it. I'll ping back on this thread soon.

Since yesterday's attempts, I haven't been able to reproduce the bug again, so
far. Apart from re-building the kernel, I have also blacklisted the particular
USB device from power savings (based on your hint). I don't know if disabling
the power savings for that USB device is the cause for not seeing the issue, but
so far, the device seems to report data.

Do you think power savings mode can impact these devices ? I know of USB plugged
keyboard/mice to generally break, when enabling power savings mode. But I had
hoped that in-built USB devices were immune to it.

Thanks,
Ritesh

- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAlhmOzUACgkQpjpYo/Lh
dWndcw/+J2WQhL6BrK1l1o2PraJtEKxnBbonOX7qZJOWnAvwX6/uH95N0u2fv9xU
SR4yMLugXM/iKlPpGCk8QmSWuQaJPjCOBole/gq4d4qCoda5z7zqnaSnCUuZgQvO
Ffn8uTPmctwtyWHh7NSWNc2yCsWJ4Auv4gRznFfxa27x0VlY9KqGBjz8oM2P0qUf
Xr3Da0oxxEdeZykkeyFa2LSESFwXCNf405nL/MuSRzJ49wUeG25ctSyE1HL3RmG/
hVoFmh6XTYiKIXjznH/upqCxvEMI46ObZKHIMJgx71kygx5uqWlS4D0/D5oNL1D5
OsVCuccfxvInRjL93+goCWpFFaD7czzpAdHgBGJArABl3/aG9SdjkDaKdNW6HmyX
E0FOQdJEgQ6dAkRcjxuEGqsfLqDNr7DPDJHH4yvoxqHWBS5S35IZisCjaF5h97z3
+qSHm8BUNAYR2LmQ5YwpispzrZGydj6ZEUt4Fhv/Wh2V3uK5fTTTEsSWfFndphsG
Ux3gMdREXNPrsj0p+9KDeuv2co+zpXIapLctHvGvsLddDOfj39Q/+KQPS9vsct3F
S8L4RrBTnTyyudsWNyPf9SUZmRK8KucbcpRE7gGJDpAHJBf6nmtD0QhB3RIfvYh0
duRGENCF7k2L7de4c9XVS3x5gWLYMV2dIx/aRC1nQsCZRkt0ORs=
=wtYI
-----END PGP SIGNATURE-----

