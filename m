Return-Path: <SRS0=eBr9=QH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FA2C169C4
	for <linux-iio@archiver.kernel.org>; Thu, 31 Jan 2019 20:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AF3218AF
	for <linux-iio@archiver.kernel.org>; Thu, 31 Jan 2019 20:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tno.nl header.i=@tno.nl header.b="BHgo8bt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfAaUZm (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:25:42 -0500
Received: from fromintouta.tno.nl ([134.221.1.26]:51837 "EHLO
        fromintouta.tno.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfAaUZm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 31 Jan 2019 15:25:42 -0500
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Jan 2019 15:25:40 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tno.nl; l=2916; s=mta1; t=1548966340;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kmNvsKZ4YgeTAMKQ51tRoqZ7qrBi27QGSKBdYlJFeH0=;
  b=BHgo8bt1piuiOVLKHOwXODWIZZai5rVVHgZH4RXpEjMgRBCl8yP4k+BV
   5sdMkpJlGyPlghjc7KK0t9Y8KWkr4/JjZdSxLZnkPg6m1+aaW7N+mwDnS
   aMDsZngcXCf+RIRI96k6cdYvf+DlGUaC8L613nzMdQegSXmXwLxBuFbHt
   w=;
X-IronPort-AV: E=Sophos;i="5.56,545,1539640800"; 
   d="scan'208";a="39741246"
Received: from UCP32.tsn.tno.nl (134.221.225.177) by UCP15.tsn.tno.nl
 (134.221.225.175) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 31 Jan
 2019 21:16:01 +0100
Received: from UCP32.tsn.tno.nl ([fe80::19:c898:c688:34d8]) by
 UCP32.tsn.tno.nl ([fe80::19:c898:c688:34d8%9]) with mapi id 15.01.1591.008;
 Thu, 31 Jan 2019 21:16:01 +0100
From:   "Medenblik, H.J.W. (Henk)" <henk.medenblik@tno.nl>
To:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Some thoughts on metadata and iio
Thread-Topic: Some thoughts on metadata and iio
Thread-Index: AQHUuaHIZngn3vxjn0OaCxfe2p7Qxw==
Date:   Thu, 31 Jan 2019 20:16:01 +0000
Message-ID: <ea0d80d50a7146e8b09e6f1e19aa614d@tno.nl>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.221.225.191]
x-esetresult: clean, is OK
x-esetid: 37303A296B4DB569677163
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Dear IIO supporters,

I have been struggling for a while with the lack of metadata support
inside the IIO framework. I really appreciate all the tremendous work
that has been done to extend the iio framework to a very useful
subsystem which easily can be used to acquire fast data streams inside
Linux.

I have been able to implement complete FPGA systems with high datarate
devices connected and store that info to Solid State Drives or transfer
that data over the network at high speeds (thanks Analog Devices).
However, what I have been missing so far is some feature which allows me
to add metadata to these streams. I was mostly focused on what is
currently available right now and tried to understand and adapt to these
thought and 'common' practices in order to see if I was something
missing how to handle this issue of using metadata inside the IIO
framework or if someone already designed that before within the framework.

I believe there are many real world application examples where somebody
need adding metadata into the 'standard' datastreams such as ADC or DAC
data samples. The metadata that I needed to have inserted was also very
timing critical and also changing in a time critical manner, which I
believe that it could only be inserted and triggered within my HDL
hardware design. So i did.....

My solution therefore was to define a customized metadata header (custom
size) generated inside my HDL design. I also decided to make the size of
this header a multiple of the elementary data sample size such that I
would not get any alignment problems when acquiring data from my
backend. Whenever I now retrieve data from my fpga backend with custom
iio device I can get all the data that I want including the meta header.

With this 'solution' I was wondering if it would make sense if the
current framework would be extended with additional iio information
describing the iio device. Currently there are so many properties
defining the samples inside iio such as if it is voltage or light or
whatever.. Why not add something which indicates if the device has
metadata support or not by defining a dedicated property for it. A
second parameter could describe the size of the metadata header. The
combination of the two parameter extensions can then be used to help the
user software to identify positions of where the real data samples start
inside the stream.

I am wondering if this makes sense.

With kind regards,

Henk


This message may contain information that is not intended for you. If you a=
re not the addressee or if this message was sent to you by mistake, you are=
 requested to inform the sender and delete the message. TNO accepts no liab=
ility for the content of this e-mail, for the manner in which you use it an=
d for damage of any kind resulting from the risks inherent to the electroni=
c transmission of messages.

