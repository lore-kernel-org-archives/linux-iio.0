Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay01-haj2.antispameurope.com ([83.246.65.51]:60691 "EHLO
	relay01-haj2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752994Ab1AJOaH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jan 2011 09:30:07 -0500
Received: from mailgw1.iis.fraunhofer.de (mailgw1.iis.fraunhofer.de [153.96.172.4])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by relay01-haj2.antispameurope.com (ASE-Secure-MTA) with ESMTP id 757B8940A9
	for <linux-iio@vger.kernel.org>; Mon, 10 Jan 2011 15:22:17 +0100 (CET)
Received: from smtp02.iis.fraunhofer.de (mailserv02.iis.fraunhofer.de [153.96.171.52])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mailgw1.iis.fraunhofer.de (Postfix) with ESMTPS id 8D9DC2400081
	for <linux-iio@vger.kernel.org>; Mon, 10 Jan 2011 15:22:17 +0100 (CET)
Received: from [10.12.75.111] (ix1113.iis.fhg.de [10.12.75.111])
	by smtp02.iis.fraunhofer.de (Postfix) with ESMTP id 7BB54200A083
	for <linux-iio@vger.kernel.org>; Mon, 10 Jan 2011 15:22:17 +0100 (CET)
Message-ID: <4D2B1619.1010408@iis.fraunhofer.de>
Date: Mon, 10 Jan 2011 15:22:17 +0100
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: cs_change for SPI transfers
Content-Type: multipart/mixed;
 boundary="------------090507030609020002020500"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a multi-part message in MIME format.
--------------090507030609020002020500
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I think there's an error in most IIO devices that use SPI transfers.

Haavard Skinnemoen wrote:
> The normal behaviour is:
>   * After all transfers except the last: CS stays active
>   * After the last transfer: CS goes inactive
>
> The cs_change flag is used to invert this behaviour. So for the last
> transfer, cs_change indicates that CS should stay active after the
> transfer (though the driver may not actually be able to do so, e.g. if
> the message is followed by a message to a different device.)
>

The drivers in IIO set cs_change for all transfers (including the last 
in a message), which is not what we want. I can prepare a patch to 
correct this.

Regards,
-- 
Manuel Stahl
Fraunhofer-Institut IIS
Leistungsoptimierte Systeme

Nordostpark 93
D90411 Nürnberg
Telefon  +49 (0)911/58061-6419
Fax      +49 (0)911/58061-6398
E-Mail   manuel.stahl@iis.fraunhofer.de

http://www.iis.fraunhofer.de
http://www.smart-power.fraunhofer.de

--------------090507030609020002020500
Content-Type: text/x-vcard; charset=utf-8;
 name="manuel_stahl.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="manuel_stahl.vcf"

YmVnaW46dmNhcmQNCmZuOk1hbnVlbCBTdGFobA0KbjpTdGFobDtNYW51ZWwNCmVtYWlsO2lu
dGVybmV0Om1hbnVlbC5zdGFobEBpaXMuZnJhdW5ob2Zlci5kZQ0KdGVsO3dvcms6KzQ5IDkx
MSA1ODA2MS02NDE5DQp4LW1vemlsbGEtaHRtbDpGQUxTRQ0KdmVyc2lvbjoyLjENCmVuZDp2
Y2FyZA0KDQo=
--------------090507030609020002020500--
