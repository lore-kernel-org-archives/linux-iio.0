Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B456AC433FE
	for <linux-iio@archiver.kernel.org>; Thu, 10 Feb 2022 08:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbiBJI4w (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 10 Feb 2022 03:56:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbiBJI4w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Feb 2022 03:56:52 -0500
X-Greylist: delayed 374 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 00:56:53 PST
Received: from mail.trixen.pl (mail.trixen.pl [192.71.213.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86951091
        for <linux-iio@vger.kernel.org>; Thu, 10 Feb 2022 00:56:53 -0800 (PST)
Received: by mail.trixen.pl (Postfix, from userid 1001)
        id 901CE40AF0; Thu, 10 Feb 2022 09:50:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trixen.pl; s=mail;
        t=1644483038; bh=J50dbWEn9x62xyxY1PWPtYxMwNMcDFoILqXfzM3his0=;
        h=Date:From:To:Subject:From;
        b=avHqFOVPEsNBVmkFRHi3uguh+iQKDnJ/TdjpfN+Ekq28QD8vxI5JWzFMI3W9rjrHw
         KXqV3rP4o9++Y04oYAyUcKVe77cu6Fk60e8gmkB8TQ3iRNXm6GywOhPnGkrAHeYXRn
         6UB8SsLjpPLzqsF6B/8ix5/wR6gf0OfIzY6FeLGjlw3te9hrjJm+FNLBY44cqecvbd
         uHpgyIgrP1sQsC7YjQynSm2rdukNqN9DJaoDledLy/84cOYIHkcy3KzK8Xv2KU7N2B
         rHD4Ixex3T02ewXgnpzjaCcmjWizXNwdmpVUZnLpZ8P3XsgWYNpITgkY65ro3Av0W5
         0wZKyNVBCerAA==
Received: by mail.trixen.pl for <linux-iio@vger.kernel.org>; Thu, 10 Feb 2022 08:50:34 GMT
Message-ID: <20220210084500-0.1.t.1u1a.0.fz311useop@trixen.pl>
Date:   Thu, 10 Feb 2022 08:50:34 GMT
From:   =?UTF-8?Q? "Rados=C5=82aw_Grabowski" ?= 
        <radoslaw.grabowski@trixen.pl>
To:     <linux-iio@vger.kernel.org>
Subject: Monitorowanie samochodu
X-Mailer: mail.trixen.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Dzie=C5=84 dobry,

Chcia=C5=82bym przedstawi=C4=87 rozwi=C4=85zanie, kt=C3=B3re poprzez wyko=
rzystanie GPS monitoruje samochody w czasie rzeczywistym.=20

Dzi=C4=99ki temu mog=C4=85 Pa=C5=84stwo odczytywa=C4=87 wszelkie warto=C5=
=9Bci dotycz=C4=85ce np. zu=C5=BCycia paliwa czy obrot=C3=B3w silnika.

System automatycznie generuje rozbudowane raporty i pozwala dokonywa=C4=87=
 istotnych analiz.

Je=C5=BCeli interesuje Pa=C5=84stwa zwi=C4=99kszenie wydajno=C5=9Bci prac=
y i kontrola wszelkich parametr=C3=B3w floty - prosz=C4=99 o kontakt.


Pozdrawiam,
Rados=C5=82aw Grabowski
