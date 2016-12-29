Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34989 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752749AbcL2Rbp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Dec 2016 12:31:45 -0500
Received: by mail-pf0-f178.google.com with SMTP id i88so63065764pfk.2
        for <linux-iio@vger.kernel.org>; Thu, 29 Dec 2016 09:31:44 -0800 (PST)
Message-ID: <1483032694.3173.3.camel@researchut.com>
Subject: Re: sensor-hub: Move the memset to sensor_hub_get_feature()
From: Ritesh Raj Sarraf <rrs@researchut.com>
Reply-To: rrs@researchut.com
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>
Date: Thu, 29 Dec 2016 23:01:34 +0530
In-Reply-To: <1483032127.27585.13.camel@linux.intel.com>
References: <1482925101.8484.1.camel@researchut.com>
         <1482931381.8484.3.camel@researchut.com>
         <1482943685.4497.19.camel@linux.intel.com>
         <1482945855.8484.8.camel@researchut.com>
         <1482946633.12558.1.camel@researchut.com>
         <1482947598.21657.1.camel@researchut.com>
         <1483032127.27585.13.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Thu, 2016-12-29 at 09:22 -0800, Srinivas Pandruvada wrote:
> > If you need more information, please tell me.
> 
> I tried on couple of systems with the patch. It seems to fix the issue.
> It is possible some low level power related changes have impacted this.
> Can you do bisect? I suggest just try 4.9-rc1. I think it will not work
> there probably.

Okay. Let me do a bisect on it. I'll ping back on this thread soon.

Thanks.

- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAlhlSHYACgkQpjpYo/Lh
dWnmcg//QrHQozU4PprGVzFWH6aYfCC5fu4Y2nsnxU5ZyHslFchkEzzbf/E6T5y0
fPrdLsSfdnDvD+bZJTq7UsviPj9v4geXm/LuL+zYN75F7alIu4tu93ZXYTf6o8ak
XGcpAdXAMw3gtfjzfciMorTX942cMSxAd7uisIM2It9D8efoZ6zNM7Gr9qWz5lbo
cPoM3TuJEhfLq3hoAUZftm2nsk8OX/kBifpVgMPU0t/b3DxBYeX0FGbm5dbV40RP
/Cm7rcugNnLFVVsveyJYZnSBM7OYZN9t6nTtRSPXDS4OAi4QuFsDnrkokn7f1X4y
SzZbzg71WOgqOiOWZY223Q4CmAB+9oFy+IDdsLjDom+TgW79yCHFgthqJEmQhxFJ
XY7w4P/zNBZ08m3AgTmxcsFxdYD4MzPCKujg1PEBvn5mEht/ToHS1LnOKsBUVe+d
g553BXiC7jFZeRvM156ZLPH/WFqUwHa7NcAuB0Er54kgUEbOCeZWukh9W0bNO/xP
u4STPg5NvkXAxqlIGC5mrTie8oJFr8dVAnTQYsaIH+L8DAsepNsFltMyvCKqVVeB
DOsp8NISKn3W22HWfBqQDnFwSeI/ZxarzSbI0Ke8qbB/Bd38aGbXcwZ9+mLPBS+M
4+DdgY5oZlN7D96wEEjJPnsMbgsEu143Tf1MydkfyMlFFHayz0s=
=HcE8
-----END PGP SIGNATURE-----

