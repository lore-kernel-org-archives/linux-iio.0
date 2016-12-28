Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36001 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbcL1RyA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Dec 2016 12:54:00 -0500
Received: by mail-pf0-f179.google.com with SMTP id 189so59549421pfz.3
        for <linux-iio@vger.kernel.org>; Wed, 28 Dec 2016 09:53:44 -0800 (PST)
Message-ID: <1482947598.21657.1.camel@researchut.com>
Subject: Re: sensor-hub: Move the memset to sensor_hub_get_feature()
From: Ritesh Raj Sarraf <rrs@researchut.com>
Reply-To: rrs@researchut.com
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>
Date: Wed, 28 Dec 2016 23:23:18 +0530
In-Reply-To: <1482946633.12558.1.camel@researchut.com>
References: <1482925101.8484.1.camel@researchut.com>
         <1482931381.8484.3.camel@researchut.com>
         <1482943685.4497.19.camel@linux.intel.com>
         <1482945855.8484.8.camel@researchut.com>
         <1482946633.12558.1.camel@researchut.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, 2016-12-28 at 23:07 +0530, Ritesh Raj Sarraf wrote:
> On Wed, 2016-12-28 at 22:54 +0530, Ritesh Raj Sarraf wrote:
> > Device4, for which there are no x, y, z attributes, reports the name
> > "dev_rotation".
> > Even for the other devices, I see no change in the reported values.
> 
> On the 4.8 kernel, the values do change. The iio-sensor-proxy still does not
> do
> the rotation.

For the sake of completeness, I booted up iio-sensor-proxy (with latest patch
from today), on both 4.8 and 4.9.

With 4.8, I am reliably able to see screen rotation. And for the record, on 4.8,
the memset change is the old one.

With 4.9, nothing. Which may be expected given there were no data seen with
those device attributes (when using cat).


If you need more information, please tell me.


- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAlhj/A8ACgkQpjpYo/Lh
dWmrVBAAmvevxwMKsO9+rcOxa4QyuV1m8dX/j13eX3pz/qPQAP+sn/AeIS7B3HVT
EdbSTAzAPEJGxR3KLxYP4+3L30RO4V94T371h9INujJWAFbu29J2p2WiUtTWtpLI
ZtBrS4x7pPRUdn6io9AMKfGFSZdDoskfCHbCC/lUN05zXJnKZRYXSRispSJ6c02F
f9A8zwaTGC+lrP3uLJ/0l9nPa545ivyCPYyfBrbpBedV/9NO2YfPbGxGETpUOEt+
7YCxC2W/mVVmbm5bdAbZ8EwoWsl/AWuy93/A5AAse1LF1o//eZXc8Dry0VKzkm8t
lq/yZYGwKLgT8vgQwoTyNSO19o+P96NY/WkiOxTCj4ZMHFAXz1+v1FWKDzwKlaPc
Egyw1Go3Rd0xciZBmZeru6szmKL+daJBKhZSHyoMjYVtaxp49EtsDjkv7lhsUvWI
hj2ctO8vLo1UNq+V26icP2ofaWuLpjd7hx9jTt5PhEEmK0yus3HnI0S417FMlDvU
dqpJKLRTAdO6sGYyVuMs9U/7Q5mRAzEgeOHlLGkghCfH+163HPCY4uNq4QZ9wj5Y
XioSJ/HjFW6R0Mxyr9jI5WcFQ82QcGsoOzocyjbxYWK7SFknRtkIDt3fQaEqvCSq
9tATFHcoUIQXCrk00uOj2ZYsBqlhN3PFaqJm9irSJdWpdnqUNtE=
=5uwZ
-----END PGP SIGNATURE-----

