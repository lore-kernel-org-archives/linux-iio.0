Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:51863 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932316AbdERMNS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 18 May 2017 08:13:18 -0400
From: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
To: jic23@kernel.org
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-iio@vger.kernel.org,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: [PATCH v5 0/9] iio: light: rpr0521
Date: Thu, 18 May 2017 15:12:48 +0300
Message-Id: <1495109577-29596-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Patchset v4->v5 changes:
  cover letter added
  0002 (void) removed

Patchset v3->v4 changes:
  0006 indent fix
  0009 on/off to preenable/postdisable

Patchset v2->v3 changes:
  More commits, numbers change, order change
  Changes listed in individual commits

Mikko Koivunen (9):
  iio: light: rpr0521 disable sensor -bugfix
  iio: light: rpr0521 poweroff for probe fails
  iio: light: rpr0521 on-off sequence change for CONFIG_PM
  iio: light: rpr0521 magic number to sizeof() on value read
  iio: light: rpr0521 whitespace fixes
  iio: light: rpr0521 sample_frequency read/write
  iio: light: rpr0521 proximity offset read/write
  iio: light: rpr0521 channel numbers reordered
  iio: light: rpr0521 triggered buffer

 drivers/iio/light/rpr0521.c |  597 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 549 insertions(+), 48 deletions(-)

-- 
1.7.9.5

