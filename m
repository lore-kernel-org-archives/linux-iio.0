Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35004 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932543AbcECQW1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2016 12:22:27 -0400
Received: by mail-wm0-f53.google.com with SMTP id e201so153843758wme.0
        for <linux-iio@vger.kernel.org>; Tue, 03 May 2016 09:22:27 -0700 (PDT)
MIME-Version: 1.0
From: Gwendal Grignou <gwendal@chromium.org>
Date: Tue, 3 May 2016 09:22:06 -0700
Message-ID: <CAMHSBOWLL=O=gRwUhepuKzyGwMeiVfDw2N2A7FwQBwS-_yk+fQ@mail.gmail.com>
Subject: trigger->ops structure optional?
To: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When I decided to compile a driver with a trigger as a module, I
realized that I needed to add a trigger ops structure with the .owner
field set to THIS_MODULE.
The reason is iio_trigger_put() calls module_put(trig->ops->owner),
which is a noop if the driver is compiled within the kernel.
Otherwise, trigger->ops is considered optional.

We could add a test there to not call module_put() if ops is NULL, but
we wouldn't have the module refcount protection anymore; the trigger
could be removed while still in use given iio_trigger_unregister()
does not check if the trigger is still in use.

To address that issue, should we make trigger->ops mandatory - its
function members could still be optional?
If we go this way, shall we go even further and fold the ops structure
within iio_trigger?

Gwendal.
