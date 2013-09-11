Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 5/5] staging: iio: tsl2x7x_core: Remove redundant break
Date: Wed, 11 Sep 2013 15:50:29 +0530
Message-Id: <1378894829-8173-5-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378894829-8173-1-git-send-email-sachin.kamat@linaro.org>
References: <1378894829-8173-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

'break' after return is redundant. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/light/tsl2x7x_core.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index 3439d37..9c43dcf 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -951,7 +951,6 @@ static ssize_t tsl2x7x_gain_available_show(struct device *dev,
 	case tsl2771:
 	case tmd2771:
 		return snprintf(buf, PAGE_SIZE, "%s\n", "1 8 16 128");
-	break;
 	}
 
 	return snprintf(buf, PAGE_SIZE, "%s\n", "1 8 16 120");
@@ -1346,7 +1345,6 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
 			break;
 		default:
 			return -EINVAL;
-			break;
 		}
 		break;
 	case IIO_CHAN_INFO_RAW:
@@ -1366,7 +1364,6 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
 			break;
 		default:
 			return -EINVAL;
-			break;
 		}
 		break;
 	case IIO_CHAN_INFO_CALIBSCALE:
@@ -1419,7 +1416,6 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
 				case tsl2772:
 				case tmd2772:
 					return -EINVAL;
-				break;
 				}
 				chip->tsl2x7x_settings.als_gain = 3;
 				break;
@@ -1431,7 +1427,6 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
 				case tsl2771:
 				case tmd2771:
 					return -EINVAL;
-				break;
 				}
 				chip->tsl2x7x_settings.als_gain = 3;
 				break;
@@ -1508,18 +1503,15 @@ static int tsl2x7x_device_id(unsigned char *id, int target)
 	case tsl2671:
 	case tsl2771:
 		return ((*id & 0xf0) == TRITON_ID);
-	break;
 	case tmd2671:
 	case tmd2771:
 		return ((*id & 0xf0) == HALIBUT_ID);
-	break;
 	case tsl2572:
 	case tsl2672:
 	case tmd2672:
 	case tsl2772:
 	case tmd2772:
 		return ((*id & 0xf0) == SWORDFISH_ID);
-	break;
 	}
 
 	return -EINVAL;
-- 
1.7.9.5
