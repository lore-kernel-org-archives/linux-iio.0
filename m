Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:50425 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbdKESAG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Nov 2017 13:00:06 -0500
From: Harinath Nampally <harinath922@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, amsfield22@gmail.com,
        martink@posteo.de
Subject: [PATCH v4 0/2] Refactor event related code
Date: Sun,  5 Nov 2017 13:00:01 -0500
Message-Id: <1509904804-4608-1-git-send-email-harinath922@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Rename some struct names improve code readability.

Harinath Nampally (2):
  iio: accel: mma8452: Rename a struct for code readibility
  iio: accel: mma8452: Rename config structs for readability

 drivers/iio/accel/mma8452.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
 v4:
 - Dropped a patch from v3 which was already merged
 - Subject line and commit message have better descriptions
2.7.4

