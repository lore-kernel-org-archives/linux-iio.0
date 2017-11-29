Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from a8-53.smtp-out.amazonses.com ([54.240.8.53]:55512 "EHLO
        a8-53.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750890AbdK2WbM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Nov 2017 17:31:12 -0500
From: Jeremy Cline <jeremy@jcline.org>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Steven Presser <steve@pressers.name>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jeremy@jcline.org>
Subject: [PATCH 0/2] iio: accel: bmc150: Check for a second i2c resource
Date: Wed, 29 Nov 2017 22:31:11 +0000
Message-ID: <0100016009e7c075-ae3eb98f-22d0-4fae-bcff-93102508b227-000000@email.amazonses.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hey folks,

Some BOSC0200 ACPI devices, like the one in the Yoga 11e, have two i2c
accelerometers listed under a single ACPI device. This checks to see if
there is an ACPI companion and if so handles a second i2c client.

Jeremy Cline (2):
  iio: accel: bmc150: Move struct definitions into the header
  iio: accel: bmc150: Check for a second ACPI device for BOSC0200

 drivers/iio/accel/bmc150-accel-core.c | 43 -------------------------------
 drivers/iio/accel/bmc150-accel-i2c.c  | 33 +++++++++++++++++++++++-
 drivers/iio/accel/bmc150-accel.h      | 48 +++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 44 deletions(-)

-- 
2.14.3

