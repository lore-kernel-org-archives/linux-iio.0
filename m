Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:45244 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbaF0RuL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jun 2014 13:50:11 -0400
Received: by mail-we0-f181.google.com with SMTP id q59so5548060wes.26
        for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2014 10:50:09 -0700 (PDT)
From: Johannes Pointner <johannes.pointner@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.de>,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/2] hwmon: ntc_thermistor: Adds support for EPCOS ntc thermistor
Date: Fri, 27 Jun 2014 19:50:06 +0200
Message-ID: <2383887.HrpgCMVlam@lenovobook>
In-Reply-To: <53AD7F8F.7070501@roeck-us.net>
References: <CAJKbBDDFD294xnqkYq_auW=ppMyPJxigYUF-YAhXZVXw3NN5Xg@mail.gmail.com> <53AD7F8F.7070501@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Guenter,

sorry for that, this was my first patch.
I send the patches now separate and with supported email client.

On Friday 27 June 2014 07:28:31 Guenter Roeck wrote:
> On 06/27/2014 05:59 AM, Johannes Pointner wrote:
> > The patch series adds support for the ntc thermistor B57330V2103 from
> > 
> >   EPCOS.
> > 
> > Signed-off-by: Johannes Pointner <johannes.pointner@gmail.com>
> 
> Hi Johannes,
> 
> you sent two patches in the same e-mail, and it is all corrupted.
> All tabs have been replaced with spaces.
> 
> Guenter
> 
> > ---
> > 
> >   Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > index 46a311e..97c9c06 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > @@ -42,6 +42,7 @@ dmo    Data Modul AG
> > 
> >   ebv    EBV Elektronik
> >   edt    Emerging Display Technologies
> >   emmicro    EM Microelectronic
> > 
> > +epcos    EPCOS AG
> > 
> >   epfl    Ecole Polytechnique Fédérale de Lausanne
> >   epson    Seiko Epson Corp.
> >   est    ESTeem Wireless Modems

