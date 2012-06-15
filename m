Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:48642 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218Ab2FORZb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 15 Jun 2012 13:25:31 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 4/6] iio: add IIO_ALTVOLTAGE to iio_event_monitor example
Date: Fri, 15 Jun 2012 19:25:26 +0200
Message-Id: <1339781128-2718-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339781128-2718-1-git-send-email-pmeerw@pmeerw.net>
References: <1339781128-2718-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO_ALTVOLTAGE is used by frequency/adf4350 and frequency/ad9523

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>

---
 .../staging/iio/Documentation/iio_event_monitor.c  |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/Documentation/iio_event_monitor.c b/drivers/staging/iio/Documentation/iio_event_monitor.c
index 2227584..4326e9e 100644
--- a/drivers/staging/iio/Documentation/iio_event_monitor.c
+++ b/drivers/staging/iio/Documentation/iio_event_monitor.c
@@ -45,6 +45,7 @@ static const char * const iio_chan_type_name_spec[] = {
 	[IIO_ANGL] = "angl",
 	[IIO_TIMESTAMP] = "timestamp",
 	[IIO_CAPACITANCE] = "capacitance",
+	[IIO_ALTVOLTAGE] = "altvoltage",
 };
 
 static const char * const iio_ev_type_text[] = {
@@ -92,6 +93,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_ANGL:
 	case IIO_TIMESTAMP:
 	case IIO_CAPACITANCE:
+	case IIO_ALTVOLTAGE:
 		break;
 	default:
 		return false;
-- 
1.7.9.5

