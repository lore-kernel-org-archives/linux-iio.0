Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:56264 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbeCLPgx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Mar 2018 11:36:53 -0400
Received: by mail-wm0-f49.google.com with SMTP id q83so17525335wme.5
        for <linux-iio@vger.kernel.org>; Mon, 12 Mar 2018 08:36:53 -0700 (PDT)
Received: from [145.109.14.69] (wcw-stud-145-109-14-69.wireless.uva.nl. [145.109.14.69])
        by smtp.googlemail.com with ESMTPSA id q49sm5571170eda.21.2018.03.12.08.36.51
        for <linux-iio@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Mar 2018 08:36:51 -0700 (PDT)
To: linux-iio@vger.kernel.org
From: David Julian Veenstra <davidjulianveenstra@gmail.com>
Subject: Moving ad2s1200 out of staging
Message-ID: <64cf50ba-b741-7799-b944-7950ec80e35b@gmail.com>
Date: Mon, 12 Mar 2018 16:36:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear IIO Community,

I have looked at the ad2s1200 driver. To clean up the code, I propose
the following:

1. Replace Licence with SPDX identifier
2. Reorder variable declarations to prefer reverse
    Christmas tree ordering.
3. Add newlines (e.g. before return statement)
4. Add documentation to the device specific struct
5. Sort headers alphabetically
6. Remove indexed property for channels as only a single channel is needed
    per type

If I understand the manual correctly, the unit of the angular velocity is
rps (not entirely sure). So to conform the IIO ABI, a scaling factor
needs to
be added (IIO_CHAN_INFO_SCALE). In addition it also misses either a
MOD_X, MOD_Y, or MOD_Z.

The documentation in Documentation/ABI/testing/sysfs-bus-iio does not
define what the unit should be for an angle. If the velocity is defined
as radians
per second, it would make sense for the angle to be defined in radians.
Is there
any agreement of what the unit should be for angles?

Besides missing features, I did not find anything else wrong with the
driver.

Best regards,
David Veenstra
