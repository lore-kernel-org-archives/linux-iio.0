Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 25/32] tools:iio:iio_event_monitor: refactor events output
Date: Sun, 31 May 2015 14:40:18 +0200
Message-Id: <a8ecccf5a12d1ebbf0a5ee22d15fc3c1f7d0ff88.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de>
References: <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Refactor the code in print_event() to reduce code duplication and better
reflect that the type is output unconditionally, as well as cascade the
dependency of the diff-channel. Saves a few lines of code, as well.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/iio_event_monitor.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 17c27bf..8e682a7 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -213,23 +213,19 @@ static void print_event(struct iio_event_data *event)
 		return;
 	}
 
-	printf("Event: time: %lld, ", event->timestamp);
+	printf("Event: time: %lld, type: %s", event->timestamp,
+	       iio_chan_type_name_spec[type]);
 
-	if (mod != IIO_NO_MOD) {
-		printf("type: %s(%s), ",
-			iio_chan_type_name_spec[type],
-			iio_modifier_names[mod]);
-	} else {
-		printf("type: %s, ",
-			iio_chan_type_name_spec[type]);
-	}
+	if (mod != IIO_NO_MOD)
+		printf("(%s)", iio_modifier_names[mod]);
 
-	if (diff && chan >= 0 && chan2 >= 0)
-		printf("channel: %d-%d, ", chan, chan2);
-	else if (chan >= 0)
-		printf("channel: %d, ", chan);
+	if (chan >= 0) {
+		printf(", channel: %d", chan);
+		if (diff && chan2 >= 0)
+			printf("-%d", chan2);
+	}
 
-	printf("evtype: %s", iio_ev_type_text[ev_type]);
+	printf(", evtype: %s", iio_ev_type_text[ev_type]);
 
 	if (dir != IIO_EV_DIR_NONE)
 		printf(", direction: %s", iio_ev_dir_text[dir]);
-- 
2.3.6
