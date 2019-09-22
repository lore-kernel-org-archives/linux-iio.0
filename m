Return-Path: <SRS0=U7qS=XR=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAB6C3A5A2
	for <linux-iio@archiver.kernel.org>; Sun, 22 Sep 2019 09:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1C720B7C
	for <linux-iio@archiver.kernel.org>; Sun, 22 Sep 2019 09:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569143948;
	bh=85ZNLfvQpFUTEyX9/+hH2ifwhCBPKZIeg9H2SdOyXEg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=K2FCKatp3O8lTha16GWQH0ddMnMWypKhcRMZZZ7tEsgouMbEwoCQBTzqEpfZh/mZZ
	 wsc1JjFKgCjbuuRyF1r1XVq73s8OEOnUf9AmCoUe2ufSzQJ206DMq8wGR4FrKSwBY6
	 VKvkvafQdkf3ysqppQFPvXQp3LipzLB+pcJfJxlI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfIVJTF (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 22 Sep 2019 05:19:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbfIVJTF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Sep 2019 05:19:05 -0400
Received: from localhost.localdomain (unknown [151.66.30.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7DD12070C;
        Sun, 22 Sep 2019 09:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569143945;
        bh=85ZNLfvQpFUTEyX9/+hH2ifwhCBPKZIeg9H2SdOyXEg=;
        h=From:To:Cc:Subject:Date:From;
        b=CxtI20o7IgzsDHFvNgxxHVlm1epOiRP60l4zKhx7YjyUmQ0iat1IKYBB8XbZH85aj
         A46xeInV9LAk7JbnbXxr75ULmfyI2M7q/4QsYS6BFcoRmQXDu6gEA3gUvnpryP1R6L
         kmrNrBnA1EFL7OgRhz4eAeovrnhwA18WbXIjtxqc=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        martin.kepplinger@puri.sm, rjones@gateworks.com
Subject: [PATCH 0/3] st_lsm6dsx: do not access active-low/open-drain if not supported
Date:   Sun, 22 Sep 2019 11:18:50 +0200
Message-Id: <cover.1569143551.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Move active low and open drain register definitions in hw_settings
register map in order to avoid to access them if the sensor does not
support them.
Group irq related definition in irq_config structure in
st_lsm6dsx_settings.

@Jonathan: I post this series now since in this way Bobby can test it and maybe
you want to apply it on top of togreg branch. If you prefer to add it on
testing branch I can rebase it ontop of Sean's series.

Lorenzo Bianconi (3):
  iio: imu: st_lsm6dsx: move irq related definitions in irq_config
  iio: imu: st_lsm6dsx: do not access active-low/open-drain regs if not
    supported
  iio: imu: st_lsm6dsx: add sanity check for read_fifo pointer

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  17 +-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  35 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 243 ++++++++++++------
 3 files changed, 203 insertions(+), 92 deletions(-)

-- 
2.21.0

