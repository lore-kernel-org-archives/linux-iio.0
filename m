Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-093.synserver.de ([212.40.185.93]:1080 "HELO
	smtp-out-093.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753657Ab1LNNVT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2011 08:21:19 -0500
Message-ID: <4EE8A2E6.6070807@metafoo.de>
Date: Wed, 14 Dec 2011 14:21:42 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Should we make mark_param_change buffer implementation internal?
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Right now we have a mark_param_change callback in the buffer access
functions struct, which should be called whenever the parameters (length,
bytes per datum) of the buffer change. Each buffer implementation calls
their own mark_param_change callback in their set_length and
set_bytes_per_datum callbacks. Additionally mark_param_change gets called
when the user changes the buffer length. So in this case it will get called
twice.

So I'm wondering if we should make it completely buffer implementation
internal and not export it in the buffer access functions struct, since the
buffer implementation will probably know best anyway if one of it's
parameters has changed.

- Lars
