Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtprelay0076.hostedemail.com ([216.40.44.76]:48846 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751870Ab3JJXID (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 Oct 2013 19:08:03 -0400
Message-ID: <1381446479.14017.16.camel@joe-AO722>
Subject: [Trivial PATCH] staging: Remove unnecessary semicolons
From: Joe Perches <joe@perches.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	linux-iio <linux-iio@vger.kernel.org>,
	devel <devel@driverdev.osuosl.org>,
	LKML <linux-kernel@vger.kernel.org>
Date: Thu, 10 Oct 2013 16:07:59 -0700
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These aren't necessary after switch, if and while statements.

Also remove some unnecessary braces where these
semicolons were removed around single statement
and some unnecessary blank lines.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/staging/iio/adc/ad7291.c                |  2 +-
 drivers/staging/iio/cdc/ad7150.c                |  2 +-
 drivers/staging/imx-drm/imx-tve.c               |  2 +-
 drivers/staging/lustre/lustre/lvfs/lvfs_linux.c |  2 +-
 drivers/staging/rtl8188eu/core/rtw_recv.c       |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c    | 10 ++--------
 6 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 1dae1ef..ccaa8d6f8 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -290,7 +290,7 @@ static int ad7291_read_event_value(struct iio_dev *indio_dev,
 		return 0;
 	default:
 		return -EINVAL;
-	};
+	}
 }
 
 static int ad7291_write_event_value(struct iio_dev *indio_dev,
diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index f4a0341..618d820 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -300,7 +300,7 @@ static int ad7150_read_event_value(struct iio_dev *indio_dev,
 
 	default:
 		return -EINVAL;
-	};
+	}
 }
 
 static int ad7150_write_event_value(struct iio_dev *indio_dev,
diff --git a/drivers/staging/imx-drm/imx-tve.c b/drivers/staging/imx-drm/imx-tve.c
index 33d6525..59dd4d5 100644
--- a/drivers/staging/imx-drm/imx-tve.c
+++ b/drivers/staging/imx-drm/imx-tve.c
@@ -696,7 +696,7 @@ static int imx_tve_probe(struct platform_device *pdev)
 	if (val != 0x00100000) {
 		dev_err(&pdev->dev, "configuration register default value indicates this is not a TVEv2\n");
 		return -ENODEV;
-	};
+	}
 
 	/* disable cable detection for VGA mode */
 	ret = regmap_write(tve->regmap, TVE_CD_CONT_REG, 0);
diff --git a/drivers/staging/lustre/lustre/lvfs/lvfs_linux.c b/drivers/staging/lustre/lustre/lvfs/lvfs_linux.c
index f6268dc..ea37715 100644
--- a/drivers/staging/lustre/lustre/lvfs/lvfs_linux.c
+++ b/drivers/staging/lustre/lustre/lvfs/lvfs_linux.c
@@ -282,7 +282,7 @@ __s64 lprocfs_read_helper(struct lprocfs_counter *lc,
 		break;
 	default:
 		break;
-	};
+	}
 
 	return ret;
 }
diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index ba8e534..9f0f30f7 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -1586,7 +1586,7 @@ _func_enter_;
 
 		pfhdr->attrib.icv_len = pnfhdr->attrib.icv_len;
 		plist = get_next(plist);
-	};
+	}
 
 	/* free the defrag_q queue and return the prframe */
 	rtw_free_recvframe_queue(defrag_q, pfree_recv_queue);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 7d322f3..b01f6f5 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1888,9 +1888,8 @@ void rtl8192_hard_data_xmit(struct sk_buff *skb, struct net_device *dev,
 	memcpy((unsigned char *)(skb->cb), &dev, sizeof(dev));
 	skb_push(skb, priv->rtllib->tx_headroom);
 	ret = rtl8192_tx(dev, skb);
-	if (ret != 0) {
+	if (ret != 0)
 		kfree_skb(skb);
-	};
 
 	if (queue_index != MGNT_QUEUE) {
 		priv->rtllib->stats.tx_bytes += (skb->len -
@@ -1898,7 +1897,6 @@ void rtl8192_hard_data_xmit(struct sk_buff *skb, struct net_device *dev,
 		priv->rtllib->stats.tx_packets++;
 	}
 
-
 	return;
 }
 
@@ -1930,15 +1928,11 @@ int rtl8192_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		tcb_desc->bTxEnableFwCalcDur = 1;
 		skb_push(skb, priv->rtllib->tx_headroom);
 		ret = rtl8192_tx(dev, skb);
-		if (ret != 0) {
+		if (ret != 0)
 			kfree_skb(skb);
-		};
 	}
 
-
-
 	return ret;
-
 }
 
 static void rtl8192_tx_isr(struct net_device *dev, int prio)


