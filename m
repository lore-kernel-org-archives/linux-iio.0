Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:45409 "EHLO pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752329AbcLTKqa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Dec 2016 05:46:30 -0500
Date: Tue, 20 Dec 2016 11:46:27 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Matthias Klumpp <matthias@tenstral.net>
cc: linux-iio@vger.kernel.org
Subject: Re: Problems with using IIO buffers
In-Reply-To: <CAKNHny-B-tyZ3GszV-DLxRKzhhCuqELUc6MsiPs=76GYghO58g@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1612201144140.4422@pmeerw.net>
References: <CAKNHny-B-tyZ3GszV-DLxRKzhhCuqELUc6MsiPs=76GYghO58g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

> I am having troubles getting buffers to work with IIO. Querying raw
> data from devices works well via sysfs, but buffered input from ADCs
> does not work.

how do you setup the buffer from userspace? see e.g.
http://events.linuxfoundation.org/sites/events/files/slides/lceu15_baluta.pdf, 
page 21

regards, p.

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
