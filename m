Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:19973 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932206AbdJZMTg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Oct 2017 08:19:36 -0400
Date: Thu, 26 Oct 2017 15:19:21 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] HID: sensor: Use the correct type instead of a void pointer
Message-ID: <20171026121921.kmyk42wo32juv6qj@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

It's cleaner to declare this with the correct type instead of using a
void pointer.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 0bcf041368c7..4f509f13f347 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -485,7 +485,7 @@ static int hid_sensor_custom_add_field(struct hid_sensor_custom *sensor_inst,
 				       struct hid_field *field)
 {
 	struct hid_sensor_custom_field *sensor_field;
-	void *fields;
+	struct hid_sensor_custom_field *fields;
 
 	fields = krealloc(sensor_inst->fields,
 			  (sensor_inst->sensor_field_count + 1) *
