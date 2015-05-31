Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 12/32] tools:iio:generic_buffer: sign-extend and shift data
Date: Sun, 31 May 2015 14:39:58 +0200
Message-Id: <09b071f8d6ae17166a1230ee8708ed65f2e2978d.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de>
References: <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Refactor process_scan() to handle signed and unsigned data, respect shifts
and the data mask for 2, 4 and 8 byte sized scan elements.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/generic_buffer.c | 97 +++++++++++++++++++++++++++++-----------------
 1 file changed, 62 insertions(+), 35 deletions(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index a3cf8e3..bd974b8 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -59,33 +59,80 @@ int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
 	return bytes;
 }
 
-void print2byte(int input, struct iio_channel_info *info)
+void print2byte(uint16_t input, struct iio_channel_info *info)
 {
 	/* First swap if incorrect endian */
 	if (info->be)
-		input = be16toh((uint16_t)input);
+		input = be16toh(input);
 	else
-		input = le16toh((uint16_t)input);
+		input = le16toh(input);
 
 	/*
 	 * Shift before conversion to avoid sign extension
 	 * of left aligned data
 	 */
 	input >>= info->shift;
+	input &= info->mask;
 	if (info->is_signed) {
-		int16_t val = input;
+		int16_t val = (int16_t)(input << (16 - info->bits_used)) >>
+			      (16 - info->bits_used);
+		printf("%05f ", ((float)val + info->offset) * info->scale);
+	} else {
+		printf("%05f ", ((float)input + info->offset) * info->scale);
+	}
+}
 
-		val &= (1 << info->bits_used) - 1;
-		val = (int16_t)(val << (16 - info->bits_used)) >>
-			(16 - info->bits_used);
-		printf("%05f ", ((float)val + info->offset)*info->scale);
+void print4byte(uint32_t input, struct iio_channel_info *info)
+{
+	/* First swap if incorrect endian */
+	if (info->be)
+		input = be32toh(input);
+	else
+		input = le32toh(input);
+
+	/*
+	 * Shift before conversion to avoid sign extension
+	 * of left aligned data
+	 */
+	input >>= info->shift;
+	input &= info->mask;
+	if (info->is_signed) {
+		int32_t val = (int32_t)(input << (32 - info->bits_used)) >>
+			      (32 - info->bits_used);
+		printf("%05f ", ((float)val + info->offset) * info->scale);
 	} else {
-		uint16_t val = input;
+		printf("%05f ", ((float)input + info->offset) * info->scale);
+	}
+}
 
-		val &= (1 << info->bits_used) - 1;
-		printf("%05f ", ((float)val + info->offset)*info->scale);
+void print8byte(uint64_t input, struct iio_channel_info *info)
+{
+	/* First swap if incorrect endian */
+	if (info->be)
+		input = be64toh(input);
+	else
+		input = le64toh(input);
+
+	/*
+	 * Shift before conversion to avoid sign extension
+	 * of left aligned data
+	 */
+	input >>= info->shift;
+	input &= info->mask;
+	if (info->is_signed) {
+		int64_t val = (int64_t)(input << (64 - info->bits_used)) >>
+			      (64 - info->bits_used);
+		/* special case for timestamp */
+		if (info->scale == 1.0f && info->offset == 0.0f)
+			printf("%" PRId64 " ", val);
+		else
+			printf("%05f ",
+			       ((float)val + info->offset) * info->scale);
+	} else {
+		printf("%05f ", ((float)input + info->offset) * info->scale);
 	}
 }
+
 /**
  * process_scan() - print out the values in SI units
  * @data:		pointer to the start of the scan
@@ -108,32 +155,12 @@ void process_scan(char *data,
 				   &channels[k]);
 			break;
 		case 4:
-			if (!channels[k].is_signed) {
-				uint32_t val = *(uint32_t *)
-					(data + channels[k].location);
-				printf("%05f ", ((float)val +
-						 channels[k].offset)*
-				       channels[k].scale);
-
-			}
+			print4byte(*(uint32_t *)(data + channels[k].location),
+				   &channels[k]);
 			break;
 		case 8:
-			if (channels[k].is_signed) {
-				int64_t val = *(int64_t *)
-					(data +
-					 channels[k].location);
-				if ((val >> channels[k].bits_used) & 1)
-					val = (val & channels[k].mask) |
-						~channels[k].mask;
-				/* special case for timestamp */
-				if (channels[k].scale == 1.0f &&
-				    channels[k].offset == 0.0f)
-					printf("%" PRId64 " ", val);
-				else
-					printf("%05f ", ((float)val +
-							 channels[k].offset)*
-					       channels[k].scale);
-			}
+			print8byte(*(uint64_t *)(data + channels[k].location),
+				   &channels[k]);
 			break;
 		default:
 			break;
-- 
2.3.6
