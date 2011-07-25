Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/4] staging:iio:various Stop drivers putting sysfs attributes in a directory named after the device.
Date: Mon, 25 Jul 2011 14:39:00 +0100
Message-Id: <1311601140-20660-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1311601140-20660-1-git-send-email-jic23@cam.ac.uk>
References: <1311601140-20660-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

No idea how this particularly 'quirk' got in there in the first
place.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dds/ad9852.c        |    1 -
 drivers/staging/iio/dds/ad9910.c        |    1 -
 drivers/staging/iio/dds/ad9951.c        |    1 -
 drivers/staging/iio/resolver/ad2s1210.c |    1 -
 drivers/staging/iio/resolver/ad2s90.c   |    1 -
 5 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/dds/ad9852.c b/drivers/staging/iio/dds/ad9852.c
index 0184585..8672265 100644
--- a/drivers/staging/iio/dds/ad9852.c
+++ b/drivers/staging/iio/dds/ad9852.c
@@ -217,7 +217,6 @@ static struct attribute *ad9852_attributes[] = {
 };
 
 static const struct attribute_group ad9852_attribute_group = {
-	.name = DRV_NAME,
 	.attrs = ad9852_attributes,
 };
 
diff --git a/drivers/staging/iio/dds/ad9910.c b/drivers/staging/iio/dds/ad9910.c
index 0fa217f..3358553 100644
--- a/drivers/staging/iio/dds/ad9910.c
+++ b/drivers/staging/iio/dds/ad9910.c
@@ -352,7 +352,6 @@ static struct attribute *ad9910_attributes[] = {
 };
 
 static const struct attribute_group ad9910_attribute_group = {
-	.name = DRV_NAME,
 	.attrs = ad9910_attributes,
 };
 
diff --git a/drivers/staging/iio/dds/ad9951.c b/drivers/staging/iio/dds/ad9951.c
index d361d1f..6c18e24 100644
--- a/drivers/staging/iio/dds/ad9951.c
+++ b/drivers/staging/iio/dds/ad9951.c
@@ -161,7 +161,6 @@ static struct attribute *ad9951_attributes[] = {
 };
 
 static const struct attribute_group ad9951_attribute_group = {
-	.name = DRV_NAME,
 	.attrs = ad9951_attributes,
 };
 
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index ecaf7bb..53cb031 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -639,7 +639,6 @@ static struct attribute *ad2s1210_attributes[] = {
 };
 
 static const struct attribute_group ad2s1210_attribute_group = {
-	.name = DRV_NAME,
 	.attrs = ad2s1210_attributes,
 };
 
diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 166e241..43a66d4 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -58,7 +58,6 @@ static struct attribute *ad2s90_attributes[] = {
 };
 
 static const struct attribute_group ad2s90_attribute_group = {
-	.name = DRV_NAME,
 	.attrs = ad2s90_attributes,
 };
 
-- 
1.7.3.4
