Return-Path: <SRS0=e/h2=QJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866AAC282D7
	for <linux-iio@archiver.kernel.org>; Sat,  2 Feb 2019 17:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B32E20869
	for <linux-iio@archiver.kernel.org>; Sat,  2 Feb 2019 17:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549129277;
	bh=cLVa8cy1Uv3ZxLUoKvoZTVubYk1KrfCOxsc1MAaSfbw=;
	h=Date:From:To:Subject:List-ID:From;
	b=phFWCd3BRwyxKD4Up/wX7isBwPrn9lZmL3oSDmBdjqNPQ3+N0gvAwjygSP5yccFGq
	 WT8c86j5932vsaXWuCF9JS6Cg945QfQRuryesXULnic4yBAXFoT/DI7D5y4JAsJh9o
	 gQgD2vy8yuoUAg7FWckvJnxziu3H7XQEt36bfHW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfBBRlQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 2 Feb 2019 12:41:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbfBBRlQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Feb 2019 12:41:16 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC5E320869;
        Sat,  2 Feb 2019 17:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549129275;
        bh=cLVa8cy1Uv3ZxLUoKvoZTVubYk1KrfCOxsc1MAaSfbw=;
        h=Date:From:To:Subject:From;
        b=J5KZ7BBVc6huGB/Pz7PjOqCQ9ULIdST4bXdQ8/c8/DjXr4yjzznw2csJ0E2H1Zsiv
         hzTwNM6h72M3UEE6YHHRqsMK6HKQoyQ8xGMjlqGyUwoo3pNISS3Y6QJ2VfuUXe0riR
         SMihLW4zd8wconPhtOZtnJXpbwcrm96WSxpxtlos=
Date:   Sat, 2 Feb 2019 17:41:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of IIO fixes for the 5.0 cycle.
Message-ID: <20190202174111.23e868c2@archlinux>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The following changes since commit 06382deac2b8a49bbc5aaa3c9118fed6da4a1ac1:

  Revert "staging: rtl8723bs: Mark ACPI table declaration as used" (2019-01-11 10:40:13 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-5.0a

for you to fetch changes up to f214ff521fb1f861c8d7f7d0af98b06bf61b3369:

  iio: ti-ads8688: Update buffer allocation for timestamps (2019-01-12 18:32:28 +0000)

----------------------------------------------------------------
First set of IIO fixes for the 5.0 cycle.

Been a busy month, so these are rather later than they should have been.

* atlas-ph-sensor:
  - Temperature scale didn't correspond to the ABI.
* axp288:
  - A few different fixes around the TS-pin handling.
* ti-ads8688
  - Not enough space in the buffer used to build the scan to allow for
    the timestamp.
* tools - iio_generic_buffer
  - Make num_loops signed so that we really are running for ever
    rather than just a long time when we specify -1.

----------------------------------------------------------------
Dan Murphy (1):
      iio: ti-ads8688: Update buffer allocation for timestamps

Hans de Goede (1):
      iio: adc: axp288: Fix TS-pin handling

Martin Kelly (1):
      tools: iio: iio_generic_buffer: make num_loops signed

Matt Ranostay (1):
      iio: chemical: atlas-ph-sensor: correct IIO_TEMP values to millicelsius

 drivers/iio/adc/axp288_adc.c           | 76 +++++++++++++++++++++++++++-------
 drivers/iio/adc/ti-ads8688.c           |  3 +-
 drivers/iio/chemical/atlas-ph-sensor.c |  7 ++--
 tools/iio/iio_generic_buffer.c         |  2 +-
 4 files changed, 66 insertions(+), 22 deletions(-)
