Return-Path: <SRS0=O5so=2Y=axentia.se=peda@kernel.org>
Subject: Re: [PATCH v10 03/11] mux: minimal mux subsystem and gpio-based mux
 controller
To: <linux-kernel@vger.kernel.org>
References: <1489144205-17427-1-git-send-email-peda@axentia.se>
 <1489144205-17427-4-git-send-email-peda@axentia.se>
CC: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Jonathan Cameron <jic23@kernel.org>,
	"Hartmut Knaack" <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>, Jonathan Corbet
	<corbet@lwn.net>, <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Colin Ian King <colin.king@canonical.com>, "Paul
 Gortmaker" <paul.gortmaker@windriver.com>
From: Peter Rosin <peda@axentia.se>
Message-ID: <43afcbb6-5e28-2399-95e2-10b568547c3b@axentia.se>
Date: Wed, 15 Mar 2017 23:16:22 +0100
MIME-Version: 1.0
In-Reply-To: <1489144205-17427-4-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 2017-03-10 12:09, Peter Rosin wrote:
> Add a new minimalistic subsystem that handles multiplexer controllers.
> When multiplexers are used in various places in the kernel, and the
> same multiplexer controller can be used for several independent things,
> there should be one place to implement support for said multiplexer
> controller.
> 
> A single multiplexer controller can also be used to control several
> parallel multiplexers, that are in turn used by different subsystems
> in the kernel, leading to a need to coordinate multiplexer accesses.
> The multiplexer subsystem handles this coordination.
> 
> This new mux controller subsystem initially comes with a single backend
> driver that controls gpio based multiplexers. Even though not needed by
> this initial driver, the mux controller subsystem is prepared to handle
> chips with multiple (independent) mux controllers.
> 
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Peter Rosin <peda@axentia.se>

I would like to mention a bugfix patch that I have added to the end of
the series in response to feedback from Dan Carpenter. Can be found
here: https://lkml.org/lkml/2017/3/14/700

And I have also amended the below editorials to this patch.

Cheers,
peda

diff --git a/include/linux/mux.h b/include/linux/mux.h
index 7ef0864c8f38..febdde4246df 100644
--- a/include/linux/mux.h
+++ b/include/linux/mux.h
@@ -20,6 +20,10 @@ struct mux_chip;
 struct mux_control;
 struct platform_device;

+/**
+ * struct mux_control_ops -    Mux controller operations for a mux chip.
+ * @set:                       Set the state of the given mux controller.
+ */
 struct mux_control_ops {
        int (*set)(struct mux_control *mux, int state);
 };
@@ -29,7 +33,7 @@ struct mux_control_ops {
 #define MUX_IDLE_DISCONNECT (-2)

 /**
- * struct mux_control - Represents a mux controller.
+ * struct mux_control -        Represents a mux controller.
  * @lock:              Protects the mux controller state.
  * @chip:              The mux chip that is handling this mux controller.
  * @states:            The number of mux controller states.
@@ -50,7 +54,7 @@ struct mux_control {
 /**
  * struct mux_chip -   Represents a chip holding mux controllers.
  * @controllers:       Number of mux controllers handled by the chip.
- * @mux:               Array of mux controllers that is handled.
+ * @mux:               Array of mux controllers that are handled.
  * @dev:               Device structure.
  * @id:                        Used to identify the device internally.
  * @ops:               Mux controller operations.
@@ -176,7 +180,7 @@ void devm_mux_chip_free(struct device *dev, struct mux_chip *mux_chip);
  * mux_control_deselect() if mux_control_select() fails.
  *
  * Return: 0 if the requested state was already active, or 1 it the
- * mux-control state was changed to the requested state. Or a negavive
+ * mux-control state was changed to the requested state. Or a negative
  * errno on error.
  *
  * Note that the difference in return value of zero or one is of
@@ -192,13 +196,13 @@ int mux_control_select(struct mux_control *mux, int state);
  *
  * Return: 0 on success and a negative errno on error. An error can only
  * occur if the mux has an idle state. Note that even if an error occurs, the
- * mux-control is unlocked for others to access.
+ * mux-control is unlocked and is thus free for the next access.
  */
 int mux_control_deselect(struct mux_control *mux);

 /**
  * mux_control_get_index() - Get the index of the given mux controller
- * @mux: The mux-control to the the index for.
+ * @mux: The mux-control to get the index for.
  *
  * Return: The index of the mux controller within the mux chip the mux
  * controller is a part of.
