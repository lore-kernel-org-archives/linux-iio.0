Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] IIO: Documentation: iio_utils: fix channel array generation.
Date: Thu, 24 Feb 2011 13:41:49 +0100
Message-ID: <1298551309-20589-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

The previous implementation flawed, in case some channels are not enabled.
The sorted array would then include channel information of disabled channels,
And misses the enabled ones, when the count is reached.
More troublesome, the loop would not even terminate.

The fix is twofold:

First we skip channels that are not enabled.
Then we use a tested bubble sort algorithm to sort the array.
Since we already allocated exactly the number of bytes we need.
We can exercise bubble sort on the original memory.
In all cases I've seen, the array is already sorted, so this sort
terminates immediately.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/Documentation/iio_utils.h |   53 ++++++++++++++----------
 1 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index 1b33c04..da10b4e 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -242,6 +242,25 @@ error_ret:
 	return ret;
 }
 
+/**
+ * bsort_channel_array_by_index() - reorder so that the array is in index order
+ *
+ **/
+
+inline void bsort_channel_array_by_index(struct iio_channel_info **ci_array, int cnt)
+{
+
+	struct iio_channel_info temp;
+	int x,y;
+
+	for(x=0; x<cnt; x++)
+		for(y=0; y<(cnt - 1); y++)
+			if((*ci_array)[y].index > (*ci_array)[y+1].index) {
+				temp = (*ci_array)[y+1];
+				(*ci_array)[y+1] = (*ci_array)[y];
+				(*ci_array)[y] = temp;
+			}
+}
 
 /**
  * build_channel_array() - function to figure out what channels are present
@@ -254,7 +273,7 @@ inline int build_channel_array(const char *device_dir,
 {
 	DIR *dp;
 	FILE *sysfsfp;
-	int count = 0, temp, i;
+	int count, temp, i;
 	struct iio_channel_info *current;
 	int ret;
 	const struct dirent *ent;
@@ -290,11 +309,10 @@ inline int build_channel_array(const char *device_dir,
 			fscanf(sysfsfp, "%u", &ret);
 			if (ret == 1)
 				(*counter)++;
-			count++;
 			fclose(sysfsfp);
 			free(filename);
 		}
-	*ci_array = malloc(sizeof(**ci_array)*count);
+	*ci_array = malloc(sizeof(**ci_array) * (*counter));
 	if (*ci_array == NULL) {
 		ret = -ENOMEM;
 		goto error_close_dir;
@@ -321,6 +339,13 @@ inline int build_channel_array(const char *device_dir,
 			}
 			fscanf(sysfsfp, "%u", &current->enabled);
 			fclose(sysfsfp);
+
+			if (!current->enabled) {
+				free(filename);
+				count--;
+				continue;
+			}
+
 			current->scale = 1.0;
 			current->offset = 0;
 			current->name = strndup(ent->d_name,
@@ -375,26 +400,10 @@ inline int build_channel_array(const char *device_dir,
 						current->generic_name);
 		}
 	}
-	/* reorder so that the array is in index order*/
-	current = malloc(sizeof(**ci_array)*(*counter));
-	if (current == NULL) {
-		ret = -ENOMEM;
-		goto error_cleanup_array;
-	}
+
 	closedir(dp);
-	count = 0;
-	temp = 0;
-	while (count < *counter)
-		for (i = 0; i < *counter; i++)
-			if ((*ci_array)[i].index == temp) {
-				memcpy(&current[count++],
-				       &(*ci_array)[i],
-				       sizeof(*current));
-				temp++;
-				break;
-			}
-	free(*ci_array);
-	*ci_array = current;
+	/* reorder so that the array is in index order */
+	bsort_channel_array_by_index(ci_array, *counter);
 
 	return 0;
 
-- 
1.6.0.2
