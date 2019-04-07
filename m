Return-Path: <SRS0=Zm7d=SJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F3FC10F0E
	for <linux-iio@archiver.kernel.org>; Sun,  7 Apr 2019 15:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E21218D0
	for <linux-iio@archiver.kernel.org>; Sun,  7 Apr 2019 15:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554652687;
	bh=AtF8uHs3bd6DNdyWEwBmQfm/yzrtmnsXp3lVkyQzivk=;
	h=Date:From:To:Subject:List-ID:From;
	b=MW3UhCedCWJFX3Mii02YF8pyKLRye6ye4R85SwXhg4ntrN+mDisznYjLn8sq/ZwLK
	 qfsD6TAhGVd9o+ZzOXytaZvUiKyj32cPmS5BgS9aEZmfGOWLaVQkiQvuS7gTT+sdkV
	 rHAw5LMhbu0tlrOUz2AaXD/Zn2PhKsYSdSFoMwnc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfDGP6H (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 7 Apr 2019 11:58:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfDGP6G (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Apr 2019 11:58:06 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66018213F2;
        Sun,  7 Apr 2019 15:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554652686;
        bh=AtF8uHs3bd6DNdyWEwBmQfm/yzrtmnsXp3lVkyQzivk=;
        h=Date:From:To:Subject:From;
        b=jhh3c6SOrOCQqshKV7pTZFijt8P6KM/fDgF3/Sj7hxFDRajxcGUgUrx5YE7LCaLuX
         C6+e/XQH3c7/LpY4PfGcAHlHeaaJjLGKRjIma/e837ouaCSYgSb+VYys/pZ3xt1z6R
         3EJSF7Wt3aMrNJxFE2EqQ+4d5RYu3hZu+W6qKXOQ=
Date:   Sun, 7 Apr 2019 16:58:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andreas Klinger <ak@it-klinger.de>
Subject: IIO moving to yaml dt-bindings.
Message-ID: <20190407165802.320dc604@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

Rob's ground work on making dt bindings machine parseable merged a while back now.

Andreas has converted a few bindings over the last week or so which is great.
It had the side effect of making me to actually look something that had been on
my todo list for a very long time.

How to write and test the bindings can be found in
Documentation/devicetree/writing-schema.md

So going forwards, I'd like all new IIO bindings to be the yaml format.

It's up to authors of drivers that undergoing revisions to decide whether
they want to do the conversion or not, and I'll show a bit of flexibility
for a few weeks.

Whilst I am not against people looking to convert their old bindings, I will
apply a restriction on how fast I review them.  Please don't send out more
than one binding conversion at a time for now.  I'm sure it'll be a bit
of a learning curve for all of us, and we don't want to swamp reviewers.
If anyone wants to help out by reviewing yaml bindings from others, that
would be very much appreciated!

Thanks,

Jonathan


