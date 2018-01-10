Return-Path: <SRS0=QH+w=EF=sirena.org.uk=broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Alexandre Torgue <alexandre.torgue@st.com>, linux-iio@vger.kernel.org, arnaud.pouliquen@st.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "docs: driver-api: add iio hw consumer section" to the asoc tree
In-Reply-To: <1511881557-28596-3-git-send-email-arnaud.pouliquen@st.com>
Message-Id: <E1eZEKB-00053k-9T@debutante>
Date: Wed, 10 Jan 2018 11:13:39 +0000
List-ID: <linux-iio@vger.kernel.org>

The patch

   docs: driver-api: add iio hw consumer section

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 5b178943d64b85d78350ea9c86344c376d7bfe74 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Wed, 10 Jan 2018 11:13:04 +0100
Subject: [PATCH] docs: driver-api: add iio hw consumer section

This adds a section about the Hardware consumer
API of the IIO subsystem to the driver API
documentation.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/driver-api/iio/hw-consumer.rst | 51 ++++++++++++++++++++++++++++
 Documentation/driver-api/iio/index.rst       |  1 +
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/driver-api/iio/hw-consumer.rst

diff --git a/Documentation/driver-api/iio/hw-consumer.rst b/Documentation/driver-api/iio/hw-consumer.rst
new file mode 100644
index 000000000000..8facce6a6733
--- /dev/null
+++ b/Documentation/driver-api/iio/hw-consumer.rst
@@ -0,0 +1,51 @@
+===========
+HW consumer
+===========
+An IIO device can be directly connected to another device in hardware. in this
+case the buffers between IIO provider and IIO consumer are handled by hardware.
+The Industrial I/O HW consumer offers a way to bond these IIO devices without
+software buffer for data. The implementation can be found under
+:file:`drivers/iio/buffer/hw-consumer.c`
+
+
+* struct :c:type:`iio_hw_consumer` — Hardware consumer structure
+* :c:func:`iio_hw_consumer_alloc` — Allocate IIO hardware consumer
+* :c:func:`iio_hw_consumer_free` — Free IIO hardware consumer
+* :c:func:`iio_hw_consumer_enable` — Enable IIO hardware consumer
+* :c:func:`iio_hw_consumer_disable` — Disable IIO hardware consumer
+
+
+HW consumer setup
+=================
+
+As standard IIO device the implementation is based on IIO provider/consumer.
+A typical IIO HW consumer setup looks like this::
+
+	static struct iio_hw_consumer *hwc;
+
+	static const struct iio_info adc_info = {
+		.read_raw = adc_read_raw,
+	};
+
+	static int adc_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan, int *val,
+				int *val2, long mask)
+	{
+		ret = iio_hw_consumer_enable(hwc);
+
+		/* Acquire data */
+
+		ret = iio_hw_consumer_disable(hwc);
+	}
+
+	static int adc_probe(struct platform_device *pdev)
+	{
+		hwc = devm_iio_hw_consumer_alloc(&iio->dev);
+	}
+
+More details
+============
+.. kernel-doc:: include/linux/iio/hw-consumer.h
+.. kernel-doc:: drivers/iio/buffer/industrialio-hw-consumer.c
+   :export:
+
diff --git a/Documentation/driver-api/iio/index.rst b/Documentation/driver-api/iio/index.rst
index e5c3922d1b6f..7fba341bd8b2 100644
--- a/Documentation/driver-api/iio/index.rst
+++ b/Documentation/driver-api/iio/index.rst
@@ -15,3 +15,4 @@ Contents:
    buffers
    triggers
    triggered-buffers
+   hw-consumer
-- 
2.15.1
